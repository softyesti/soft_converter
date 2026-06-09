# SoftConverter

A Dart package for convert some video and images to some formats using
[cwebp](https://developers.google.com/speed/webp/docs/cwebp) and
[FFmpeg](https://ffmpeg.org/). This package is not ready for production!

## Resources

- Convert `.mp4` videos to `.webm`
- Convert `.jpg` and `.png` images to `.webp`

## Platforms

- iOS 🟡
- Linux ✅
- macOS ✅
- Android 🟡
- Windows ✅

## Pre-requisites

- Have the paths to the `cwebp` and `ffmpeg` binaries set, or have them available in the system path.

OR

- Use the Flutter installation in the `master` branch with the `--enable-dart-data-assets` flag enabled to automatically bundle dependencies via the build hook.

## How to use

### Video Conversion

```dart
import 'dart:io';

import 'package:soft_converter/soft_converter.dart';

Future<void> main() async {
  // The paths to the binaries are optional.
  //
  // If not provided, `soft_converter` will use the binaries
  // included in the bundle created during the build process.
  //
  // If your Flutter installation is not compatible with
  // `build_hooks `and `data_assets`, the system path will be used.
  final converter = SoftVideoConverter(
    ffmpegMacOS: 'path/to/bin',
    ffmpegLinux: 'path/to/bin',
    ffmpegWindows: 'path/to/bin',
  );

  try {
    final files = await converter.toWEBM(
      inputs: [File('assets/gradient.mp4')],
      output: Directory('assets/'),
    );

    for (final file in files) {
      print('Video file path: ${file.path}');
    }
  } on Exception catch (e) {
    print(e.toString());
  }
}
```

### Image Conversion

```dart
import 'dart:io';

import 'package:soft_converter/soft_converter.dart';

Future<void> main() async {
  // The paths to the binaries are optional.
  //
  // If not provided, `soft_converter` will use the binaries
  // included in the bundle created during the build process.
  //
  // If your Flutter installation is not compatible with
  // `build_hooks `and `data_assets`, the system path will be used.
  final converter = SoftImageConverter();

  try {
    final files = await converter.toWEBP(
      inputs: [File('assets/space.jpg')],
      output: Directory('assets/'),
    );

    for (final file in files) {
      print('Image file path: ${file.path}');
    }
  } on Exception catch (e) {
    print(e.toString());
  }
}
```

## Credits

- João Sereia [\<joao.sereia@softyes.com.br\>](mailto:joao.sereia@softyes.com.br)
- SoftYes TI [\<softyes.com.br\>](https://softyes.com.br)
