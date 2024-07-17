import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:soft_converter/src/exceptions.dart';

final class SoftImageConverter {
  /// Initializes [SoftImageConverter] with the paths to the cwebp binaries.
  /// If not defined, [SoftImageConverter] will use your system path.
  SoftImageConverter({
    this.cwebpWindows,
    this.cwebpMacOS,
    this.cwebpLinux,
  }) {
    if (Platform.isWindows && cwebpWindows != null) {
      _executable = cwebpWindows!;
    } else if (Platform.isMacOS && cwebpMacOS != null) {
      _executable = cwebpMacOS!;
    } else if (Platform.isLinux && cwebpLinux != null) {
      _executable = cwebpLinux!;
    } else {
      _executable = 'cwebp';
    }
  }

  /// cwebp binary path for windows
  final String? cwebpWindows;

  /// cwebp binary path for macOS
  final String? cwebpMacOS;

  /// cwebp binary path for linux
  final String? cwebpLinux;

  /// Executable name or path
  late String _executable;

  /// Convert multiple `.jpg` and `.png` images to `.webp` and
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
  /// final converter = SoftImageConverter();
  ///
  /// final output = Directory('path/to/outDir');
  /// final inputs = [File('path/to/foo.jpg'), File('path/to/foo.png')];
  ///
  /// final files = await converter.toWEBP(inputs, output);
  /// for (final file in files) {
  ///   print(file.path);
  /// }
  /// ```
  Future<List<File>> toWEBP({
    required List<File> inputs,
    Directory? output,
    int quality = 100,
  }) async {
    try {
      if (output?.existsSync() == false) {
        throw SoftConverterPathNotFound(
          'The output directory not found',
          path: output!.path,
        );
      }

      final files = inputs.map(
        (file) => _convert(input: file, output: output, quality: quality),
      );

      final converted = await Future.wait(files);
      return converted;
    } catch (e) {
      throw SoftConverterException(e);
    }
  }

  Future<File> _convert({
    required File input,
    Directory? output,
    int quality = 100,
  }) async {
    try {
      if (!input.existsSync()) {
        throw SoftConverterPathNotFound(
          'The input path not found',
          path: input.path,
        );
      }

      late String path;
      if (output != null) {
        final filename = p.basenameWithoutExtension(input.path);
        path = p.join(output.path, p.setExtension(filename, '.webp'));
      } else {
        path = p.setExtension(p.withoutExtension(input.path), '.webp');
      }

      final args = ['-q', quality.toString(), input.path, '-o', path];
      final result = await Process.run(_executable, args);

      final file = File(path);
      if (result.exitCode != 0 || !file.existsSync()) {
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
