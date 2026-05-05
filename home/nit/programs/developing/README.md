# Development

This module configures the user's development tools. It provides a complete stack for programming in different languages and frameworks.

## Files

### `default.nix`
When the profile is enabled, installs development tools:

- **Package managers**: yarn, pnpm
- **Runtimes**: nodejs_latest, python315
- **Languages**: typescript
- **Tools**: bruno (API testing), sqlitebrowser (SQLite database manager)

Provides the complete stack for modern web development with JavaScript/TypeScript and Python.

### `nvim.nix`
Configures **Neovim** as the main editor along with supporting tools:

- **ripgrep**: fast text search across projects
- **lua-language-server**: LSP language server for Lua
- **alejandra**: Nix file formatter
- **gcc**: C compiler

Neovim is chosen as the editor for its speed, extensibility via plugins and Lua configuration.

### `pawncc.nix`
Defines a custom package for **pawncc v3.10.11**, the Pawn compiler for SA-MP, fetched from the openmultiplayer/compiler repository. Included to compile gamemode scripts and plugins for SA-MP servers.

### `sampctl.nix`
Defines a custom package for **sampctl v1.12.0**, the SA-MP package manager, installed from a .deb. Used to manage dependencies and packages for SA-MP projects similarly to npm or pip.
