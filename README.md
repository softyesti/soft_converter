# Soft Converter

A Dart package/library for convert some video and images to some formats using [cwebp](https://developers.google.com/speed/webp/docs/cwebp) and [FFmpeg](https://ffmpeg.org/).
This package is not ready for production!

## Resources

- Convert .jpg and .png images to .webp
- Convert .mp4 videos to .webm

## Platforms

- Windows
- macOS
- Linux

## Pre-requisites

- Have the **cwebp** binaries or have it installed on your machine.
- Have the **FFmpeg** binaries or have it installed on your machine.

## Usage

SoftImageConverter

```dart
import 'package:soft_converter/soft_converter.dart';

Future<void> main() async {
  // The paths for the binaries are optional, if not defined
  // SoftConverter will use the system path.
  final imageConverter = SoftImageConverter(
    cwebpWindows: 'bin/cwebp_win.exe',
    cwebpMacOS: 'bin/cwebp_macos',
    cwebpLinux: 'bin/cwebp_linux',
  );

  try {
    final file = await imageConverter.toWEBP(
      input: 'assets/space.jpg',
      output: 'assets/space.webp',
    );

    print('Image file: ${file.path}');
  } catch (e) {
    rethrow;
  }
}
```

SoftVideoConverter

```dart
import 'package:soft_converter/soft_converter.dart';

Future<void> main() async {
  // The paths for the binaries are optional, if not defined
  // SoftConverter will use the system path.
  final imageConverter = SoftVideoConverter(
    ffmpegWindows: 'bin/ffmpeg_win.exe',
    ffmpegMacOS: 'bin/ffmpeg_macos',
    ffmpegLinux: 'bin/ffmpeg_linux',
  );

  try {
    final file = await imageConverter.toWEBM(
      input: 'assets/gradient.mp4',
      output: 'assets/gradient.webm',
    );

    print('Video file: ${file.path}');
  } catch (e) {
    rethrow;
  }
}
```

## Credits

- João Sereia [\<joao.sereia@softyes.com.br\>](mailto:joao.sereia@softyes.com.br)
- SoftYes TI [\<softyes.com.br\>](https://softyes.com.br)
