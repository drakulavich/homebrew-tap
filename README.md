# Homebrew Kesha

Homebrew tap for [Kesha Voice Kit](https://github.com/drakulavich/kesha-voice-kit).

## Install

```bash
brew tap oven-sh/bun
brew install drakulavich/kesha/kesha-voice-kit
kesha install
kesha audio.ogg
```

The formula installs the Bun-based CLI wrapper and the `kesha` / `parakeet`
commands. Engine binaries and models are downloaded explicitly with
`kesha install`.

## Validate The Tap Locally

```bash
brew tap oven-sh/bun
brew tap drakulavich/kesha "$(pwd)"
brew install --build-from-source drakulavich/kesha/kesha-voice-kit
brew test drakulavich/kesha/kesha-voice-kit
brew audit --strict --formula drakulavich/kesha/kesha-voice-kit
```

## Release Updates

This tap is updated from the main `drakulavich/kesha-voice-kit` release
workflow when a stable `vX.Y.Z` release is published.
