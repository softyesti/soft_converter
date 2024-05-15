.PHONY: run
default: run

run:
	@echo "Running package example"
	@dart run ./example/soft_converter_example.dart

dependencies:
	@echo "Installing dependencies"
	@dart pub get