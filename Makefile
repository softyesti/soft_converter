.PHONY: run dependencies publish publish-dry-run upgrade

default: run

run:
	@echo "Running package examples"
	@fvm dart run ./example/image_converter_example.dart
	@fvm dart run ./example/video_converter_example.dart

dependencies:
	@echo "Installing dependencies"
	@fvm dart pub get

publish:
	@echo "Publishing package"
	@fvm dart pub publish

publish-dry-run:
	@echo "Publishing package in dry-run mode"
	@fvm dart pub publish --dry-run

upgrade:
	@echo "Upgrading project"
	@fvm dart pub get
	@fvm dart pub upgrade
	@fvm dart pub upgrade --major-versions
