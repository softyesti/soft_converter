import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:soft_converter/src/exceptions.dart';

final class SoftVideoConverter {
  /// Initializes [SoftVideoConverter] with the paths to the FFmpeg binaries.
  /// If not defined, [SoftVideoConverter] will use your system path.
  SoftVideoConverter({
    this.ffmpegWindows,
    this.ffmpegMacOS,
    this.ffmpegLinux,
  }) {
    if (Platform.isWindows && ffmpegWindows != null) {
      _executable = ffmpegWindows!;
    } else if (Platform.isMacOS && ffmpegMacOS != null) {
      _executable = ffmpegMacOS!;
    } else if (Platform.isLinux && ffmpegLinux != null) {
      _executable = ffmpegLinux!;
    } else {
      _executable = 'ffmpeg';
    }
  }

  /// FFmpeg binary path for windows
  final String? ffmpegWindows;

  /// FFmpeg binary path for macOS
  final String? ffmpegMacOS;

  /// FFmpeg binary path for linux
  final String? ffmpegLinux;

  late String _executable;

  /// Convert .mp4 videos to .webm
  Future<File> toWEBM({
    required String input,
    String? output,
  }) async {
    if (!File(input).existsSync()) {
      throw SoftConverterPathNotFound(
        'The input path not found',
        path: input,
      );
    }

    try {
      final path = p.setExtension(p.withoutExtension(output ?? input), '.webm');

      final args = [
        '-i',
        input,
        '-f',
        'webm',
        '-c:v',
        'libvpx',
        '-b:v',
        '1M',
        '-acodec',
        'libvorbis',
        path,
        '-hide_banner',
      ];
      final result = await Process.run(_executable, args);

      final file = File(path);
      if (result.exitCode != 0 && !file.existsSync()) {
        throw SoftConverterProcessException(
          'Unknown error on convert image',
          code: result.exitCode,
        );
      }

      return file;
    } on ProcessException catch (e) {
      throw SoftConverterProcessException(e.message, code: e.errorCode);
    } on PathNotFoundException catch (e) {
      throw SoftConverterPathNotFound(e.message, path: e.path ?? '');
    } catch (e) {
      throw SoftConverterException(e);
    }
  }
}
