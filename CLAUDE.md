# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository containing configuration files for various development tools and utilities. The configurations are carefully curated to streamline workflow and improve productivity.

## Architecture & Structure

### Core Configuration Areas

- **config/** - Main configuration directory containing settings for various tools:
  - `nvim/` - Neovim configuration with Lua-based setup
  - `fish/` - Fish shell configuration (currently mostly commented out, using Starship prompt)
  - `ghostty/` - Terminal emulator configuration
  - `mise/` - Tool version management (managing Zig, Node.js, Ruby)
  - `raycast/` - Raycast extensions and configurations

- **bin/** - Custom shell scripts and utilities collection including:
  - Git workflow scripts (git-*, e.g., git-branch-current, git-conflicts)
  - Development utilities (cargo-watch-docs, fix-xcode, xcode-switch)
  - File manipulation tools (change-extension, organize-photos, extract)
  - System utilities (backup, lsports, ip)

- **Git Configuration** - Extensive git setup with:
  - Custom aliases for common workflows
  - Delta configured as diff/pager tool
  - Merge conflict style set to zdiff3
  - Auto-stashing and auto-squashing for rebases
  - LFS support configured

### Key Configurations

**Editor**: Neovim (nvim) is the primary editor with:
- Leader key mapped to space
- Lazy.nvim as plugin manager
- Custom configuration split across multiple Lua modules

**Shell**: Fish shell with Starship prompt configured

**Version Management**: mise (formerly rtx) manages:
- Node.js (latest)
- Ruby (version 3)
- Zig (latest)

## Common Commands

### Git Operations
```bash
# Custom git utilities available in bin/
git-branch-current    # Get current branch name
git-conflicts         # Show merge conflicts
git-delete-local-merged  # Clean up merged branches
git-sweep            # Clean up branches
git-undo             # Undo recent changes
```

### Development Utilities
```bash
e [file]             # Quick edit file
search [pattern]     # Search in files
fix-xcode           # Fix common Xcode issues
xcode-switch        # Switch Xcode versions
```

## Development Notes

- The repository uses symlinks for configuration deployment
- Git is configured with extensive aliases for productivity
- Custom scripts in `bin/` extend command-line capabilities
- Fish shell config is largely commented out, indicating transition or testing phase
- No formal build/test system - this is a configuration repository