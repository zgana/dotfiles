# Neovim 0.12 Migration TODO

This is a high-level migration checklist for the 0.11 -> 0.12 transition.
It focuses on the main workstreams rather than every small config tweak.

## LSP

- [x] Finish the native LSP migration path and confirm servers are enabled the 0.12 way.
- [x] Revisit Mason integration so install/enable behavior matches the new model.
- [x] Audit server-specific settings that were previously wired through older setup flows.
- [x] Check any buffer-local LSP mappings or attach behavior that depend on old assumptions.

## Treesitter

- [x] Update Treesitter configuration to the current plugin/API shape used by 0.12.
- [x] Verify parser installation and language coverage still line up with the config.
- [x] Recheck highlighting, indentation, and incremental selection.
- [x] Recheck Treesitter textobjects and motions.
- [x] Make sure any Treesitter-based folding behavior still works as expected.

## Downstream Consumers

- [x] Revisit plugins that rely on LSP or Treesitter behavior after the core migration lands.
- [x] Confirm filetype-specific overrides still behave correctly with the new parsing and LSP setup.

## Validation

- [x] Boot Neovim cleanly on 0.12.
- [x] Open representative files for Rust, Python, HTML, and markup-heavy workflows.
- [x] Verify LSP attachment, diagnostics, completion, folding, and Treesitter motions.

## Notes

- [x] Prefer broad, low-risk changes first.
- [x] Hold off on nitpicks until the core migration is stable.
- `quicker.nvim` now preserves its Treesitter/LSP opts through `setup()`.
- Rust buffer validation needs `rustc` on PATH.
- VimTeX is configured for Skim on macOS and generic/Okular on Linux.
- Temporary Treesitter shim: install any missing parsers from `ensure_installed` at startup, then remove this when a better parser manager settles.
