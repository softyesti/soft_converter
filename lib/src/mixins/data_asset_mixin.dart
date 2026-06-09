import 'dart:io';

import 'package:path/path.dart' as p;

/// Helper for handling `data_assets`.
mixin DataAssetMixin {
  /// Get the directory where the package's data_assets are stored.
  Directory? getDataAssetDir() {
    final dirname = p.dirname(Platform.resolvedExecutable);
    final path = p.join(
      dirname,
      'data',
      'flutter_assets',
      'packages',
      'soft_converter',
    );

    final dir = Directory(p.normalize(path));
    return dir.existsSync() ? dir : null;
  }

  /// Get a file from the package's `data_assets` directory.
  File? getDataAssetFile(String filename) {
    final dir = getDataAssetDir();
    if (dir == null) return null;

    final file = File(p.normalize(p.join(dir.path, filename)));
    return file.existsSync() ? file : null;
  }
}
