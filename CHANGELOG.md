# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2026-05-14
### Added
- macOS support: automatic detection via `uname -s` (Darwin).
- Homebrew (`brew`) as package manager for macOS.
- Interactive Homebrew installation prompt when `brew` is not found.
- `brew install` commands for all 12 tools: `cmatrix`, `cbonsai`, `sl`, `lolcat`, `cowsay`, `fortune`, `nyancat`, `asciiquarium`, `rain`, `lavat`, `pipes-sh`, and `cava`.
- macOS option (4) in the platform selection menu.

### Changed
- Updated banner and header text from "multi-distro" to "multi-plataforma".

## [1.0.0] - 2026-04-09
### Added
- `ascii-animated.sh`: Interactive bash script to install terminal animations.
- Support for Fedora/RHEL, Debian/Ubuntu, and Arch Linux package managers.
- Installation scripts for: `cmatrix`, `cbonsai`, `sl`, `lolcat`, `cowsay`, `fortune`, `nyancat`, `asciiquarium`, `rain`, `lavat`, `pipes.sh`, and `cava`.
- Aesthetic `README.md` with instructions and epic tool combos.
- `.gitignore` for `.atl` directory and generic temporary files.
