.PHONY dependencies

default: dependencies

dependencies:
	@echo "Installing dependencies"
	@dart pub get
