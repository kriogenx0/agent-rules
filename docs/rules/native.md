# Native

For macOS/iOS development.

## Build directory

macOS app builds go in `build/` at the repo root, not `.build/`. Point the build tools there instead of their defaults (for example `swift build --scratch-path build` or `xcodebuild -derivedDataPath build`), keep `build/` in `.gitignore`, and have `make dev`, `make open`, and `make install` use the app from `build/`.

## Makefile

Every native app should have a make file.

```sh
# Building
make dev - Build for development, close it if its open, delete old build, then open the new build.
make build - Build for production.
make clean - Clean existing builds. Removes `build/`.

make setup - Setup the environment if needed.

make open - Open dev app.
make close - kill the app. Only if native.

# Production
make install - Build for production and install to /Applications folder.
make uninstall - make close. Remove if installed.
make reinstall - make uninstall, make install
make install-open - make close if the app is running, make install, then open the installed app from /Applications. macOS only.

# Help
make all - default to run. Same as `make setup` and `make dev`
make help - help for all make commands, grouped by category.
```