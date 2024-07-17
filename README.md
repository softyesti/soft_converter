# Soft Converter

A Dart package/library for convert some video and images to some formats using [cwebp](https://developers.google.com/speed/webp/docs/cwebp) and [FFmpeg](https://ffmpeg.org/).
This package is not ready for production!

## Resources

- Convert `.jpg` and `.png` images to `.webp`
- Convert `.mp4` videos to `.webm`

## Platforms

- Windows
- macOS
- Linux

## Pre-requisites

- Have the `cwebp` binary or have it installed and available in the system path
- Have the `FFmpeg` binary or have it installed and available in the system path

## Usage

### SoftImageConverter

```dart
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:soft_converter/soft_converter.dart';

Future<void> main() async {
  // The paths for the binaries are optional, if not defined
  // SoftConverter will use the system path.
  final converter = SoftImageConverter();

  try {
    final files = await converter.toWEBP(
      inputs: [File('assets/space.jpg')],
      output: Directory('assets/'),
    );

    for (final file in files) {
      print('Image file path: ${file.path}');
    }
  } catch (e) {
    rethrow;
  }
}
```

### SoftVideoConverter

```dart
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:soft_converter/soft_converter.dart';

Future<void> main() async {
  // The paths for the binaries are optional, if not defined
  // SoftConverter will use the system path.
  final converter = SoftVideoConverter();

  try {
    final files = await converter.toWEBM(
      inputs: [File('assets/gradient.mp4')],
      output: Directory('assets/'),
    );

    for (final file in files) {
      print('Video file path: ${file.path}');
    }
  } catch (e) {
    rethrow;
  }
}
```

## Credits

- João Sereia [\<joao.sereia@softyes.com.br\>](mailto:joao.sereia@softyes.com.br)
- SoftYes TI [\<softyes.com.br\>](https://softyes.com.br)
