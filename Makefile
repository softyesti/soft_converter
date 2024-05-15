.PHONY: run
default: run

run:
	@echo "Running package examples"
	@dart run ./example/image_converter_example.dart
	@dart run ./example/video_converter_example.dart

dependencies:
	@echo "Installing dependencies"
	@dart pub get

publish:
	@echo "Publishing package"
	@dart pub publish

publish-dry-run:
	@echo "Publishing package in dry-run mode"
	@dart pub publish --dry-run