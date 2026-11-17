# Native

For macOS/iOS development.

## Build directory

macOS app builds go in `build/` at the repo root, not `.build/`. Point the build tools there instead of their defaults (for example `swift build --scratch-path build` or `xcodebuild -derivedDataPath build`), keep `build/` in `.gitignore`, and have `make dev`, `make open`, and `make install` use the app from `build/`.

## CI builds

With [prototyping mode](prototyping-mode.md) on, GitHub Actions builds native apps only when a release is tagged, not on every push or pull request. Trigger the native build workflow on tag pushes (`on: push: tags: ['v*']`, matching the tags `make release` creates; see [versioning.md](versioning.md)) and drop its `push` and `pull_request` branch triggers. Other checks (tests, lint) still run as the project's CI defines. With prototyping mode off, leave the project's existing triggers alone.

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