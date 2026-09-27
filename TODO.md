# TODO

## Installer correctness

- [ ] Ensure `--dry` makes no filesystem changes, including destination directories.
- [ ] Handle dangling destination symlinks before creating a new link.
- [ ] Fail with a clear error when a configured source directory is missing.
- [ ] Report when an existing symlink points somewhere other than the repository.
- [ ] Decide whether incorrect existing symlinks should be replaced or left untouched.

## Safety

- [ ] Add checks that the repository path and `$HOME` are the expected locations before installing.
- [ ] Consider rollback behavior if installation fails partway through.
- [ ] Preserve and clearly report backups created for existing files and directories.

## macOS setup

- [ ] Add `set -euo pipefail` to `setup-macos.sh`.
- [ ] Check that Homebrew is installed before running `brew` commands.
- [ ] Make package installation idempotent by avoiding reinstalling existing formulas.
- [ ] Consolidate Homebrew package installation into one command where appropriate.
- [ ] Handle or document failures when starting the `sleepwatcher` service.

## Testing

- [ ] Add tests for backup behavior.
- [ ] Add tests confirming dry runs do not modify the filesystem.
- [ ] Add tests for existing, incorrect, and dangling symlinks.
- [ ] Add tests for missing source directories.

## Documentation

- [ ] Document the install commands in `README.md`.
- [ ] Document the difference between `install.py --dry`, `install.py`, and `setup-macos.sh`.
- [ ] Fix the README link reference for `install.py` if it is intended to be a link.
