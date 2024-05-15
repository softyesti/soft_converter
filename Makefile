.PHONY: run
default: run

run:
	@echo "Running package example"
	@dart run ./example/soft_image_converter_example.dart
	@dart run ./example/soft_video_converter_example.dart

dependencies:
	@echo "Installing dependencies"
	@dart pub get