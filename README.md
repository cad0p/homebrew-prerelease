# Cad0p Prerelease Tap

Homebrew tap for prerelease `cad0p` formulae.

Stable formulae live in [`cad0p/homebrew-tap`](https://github.com/cad0p/homebrew-tap).

## Prerequisites

`ghostty-zmx` depends on zmx from the upstream `neurosnap/tap` tap:

```sh
brew tap neurosnap/tap
```

## Formulae

### `ghostty-zmx`

Prerelease builds of Ghostty + zmx session management integration. This formula tracks the project's prerelease channel and is intended for testing new changes before stable releases.

Install directly:

```sh
brew install cad0p/prerelease/ghostty-zmx
```

After installation, configure your shell and Ghostty config by running:

```sh
ghostty-zmx-install
```

Then restart Ghostty or open a new Ghostty window.

## Development

Formula files live under `Formula/`:

```text
Formula/ghostty-zmx.rb
```

Before pushing formula changes, test locally:

```sh
brew install --build-from-source cad0p/prerelease/ghostty-zmx
brew test cad0p/prerelease/ghostty-zmx
brew audit --strict cad0p/prerelease/ghostty-zmx
```

## Documentation

`brew help`, `man brew`, or [Homebrew's documentation](https://docs.brew.sh).
