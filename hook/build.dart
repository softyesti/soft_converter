import 'dart:io';

import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:code_assets/code_assets.dart';
import 'package:data_assets/data_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

void main(List<String> args) async => await build(args, (input, output) async {
  if (!input.config.buildDataAssets) return;

  final os = input.config.code.targetOS;
  final outPath = Directory.fromUri(input.outputDirectoryShared).path;

  final ext = os == .windows ? '.exe' : '';
  final cwebpFilename = p.setExtension('cwebp', ext);
  final ffmpegFilename = p.setExtension('ffmpeg', ext);

  final cwebpFile = File(p.join(outPath, cwebpFilename));
  final ffmpegFile = File(p.join(outPath, ffmpegFilename));

  if (!cwebpFile.existsSync()) {
    await downloadCWEBP(os, cwebpFile);
  }

  if (!ffmpegFile.existsSync()) {
    await downloadFFMPEG(os, ffmpegFile);
  }

  output.assets.data.addAll([
    DataAsset(
      file: cwebpFile.uri,
      name: cwebpFilename,
      package: input.packageName,
    ),
    DataAsset(
      file: ffmpegFile.uri,
      name: ffmpegFilename,
      package: input.packageName,
    ),
  ]);
});

Future<void> downloadCWEBP(OS os, File output) async {
  const base =
      'https://github.com/imagemin/cwebp-bin/raw/91dfc0009418539cb2dbdc90a10830c4c5e84028/vendor';

  final path = switch (os) {
    .macOS => 'osx/cwebp',
    .linux => 'linux/x64/cwebp',
    .windows => 'win/x64/cwebp.exe',
    _ => throw UnsupportedError('Unsupported platform: ${os.name}'),
  };

  await _download(.parse(p.join(base, path)), output);
}

Future<void> downloadFFMPEG(OS os, File output) async {
  const base =
      'https://github.com/ffbinaries/ffbinaries-prebuilt/releases/download';

  const arch = '64';
  const name = 'ffmpeg';
  const version = '6.1';
  final system = switch (os) {
    .macOS => 'macos',
    .linux => 'linux',
    .windows => 'win',
    _ => throw UnsupportedError('Unsupported platform: ${os.name}'),
  };

  final filename = '$name-$version-$system-$arch.zip';
  final file = File(p.join(Directory.systemTemp.path, filename));

  await _download(.parse(p.join(base, 'v$version', filename)), file);

  final archive = ZipDecoder().decodeBytes(await file.readAsBytes());
  await output.writeAsBytes(archive.first.readBytes() ?? []);
}

Future<void> _download(Uri url, File output) async {
  final resp = await http.get(url);
  if (resp.statusCode == 200) {
    if (output.existsSync()) return;

    await output.create(recursive: true);
    await output.writeAsBytes(resp.bodyBytes);
    return;
  }

  final code = resp.statusCode;
  final reason = resp.reasonPhrase;
  throw Exception('Failed to download $url: $code $reason');
}
