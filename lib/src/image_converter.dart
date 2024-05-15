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

  late String _executable;

  /// Convert .jpg and .png images to .webp
  Future<File> toWEBP({
    required String input,
    int quality = 100,
    String? output,
  }) async {
    if (!File(input).existsSync()) {
      throw SoftConverterPathNotFound(
        'The input path not found',
        path: input,
      );
    }

    try {
      final path = p.setExtension(p.withoutExtension(output ?? input), '.webp');

      final args = ['-q', quality.toString(), input, '-o', path];
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
