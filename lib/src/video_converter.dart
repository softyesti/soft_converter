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

  /// Executable name or path
  late String _executable;

  /// Convert multiple `.mp4` videos to `.webm` and
  /// return a list of converted files.
  ///
  /// Throws
  /// - [SoftConverterPathNotFound] if any path does't exists;
  /// - [SoftConverterProcessException] if occur any conversion error;
  /// - [SoftConverterException] if occur unknown errors.
  ///
  /// Example:
  ///
  /// ```dart
  /// final converter = SoftVideoConverter();
  ///
  /// final output = Directory('path/to/outDir');
  /// final inputs = [File('path/to/foo.mp4'), File('path/to/foo.mp4')];
  ///
  /// final files = await converter.toWEBM(inputs, output);
  /// for (final file in files) {
  ///   print(file.path);
  /// }
  /// ```
  Future<List<File>> toWEBM({
    required List<File> inputs,
    Directory? output,
  }) async {
    try {
      if (output?.existsSync() == false) {
        throw SoftConverterPathNotFound(
          'The output directory not found',
          path: output!.path,
        );
      }

      final files = inputs.map((file) => _convert(input: file, output: output));
      final converted = await Future.wait(files);
      return converted;
    } catch (e) {
      throw SoftConverterException(e);
    }
  }

  Future<File> _convert({
    required File input,
    Directory? output,
  }) async {
    try {
      if (!input.existsSync()) {
        throw SoftConverterPathNotFound(
          'The input file not found',
          path: input.path,
        );
      }

      late String path;
      if (output != null) {
        final filename = p.basenameWithoutExtension(input.path);
        path = p.join(output.path, p.setExtension(filename, '.webm'));
      } else {
        path = p.setExtension(p.withoutExtension(input.path), '.webm');
      }

      final args = [
        '-i',
        input.path,
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

      final file = File(path);
      final result = await Process.run(_executable, args);
      if (result.exitCode != 0 || !file.existsSync()) {
        throw SoftConverterProcessException(
          'Unknown error on convert video',
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
