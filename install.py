#!/usr/bin/env -S uv run


import argparse
import datetime
from pathlib import Path


BASE_INSTALL_DIRS: dict[str, str] = {
    # ghostty
    "config/ghostty": ".config/ghostty",
    # karabiner
    "config/karabiner/assets/complex_modifications": ".config/karabiner/assets/complex_modifications",
    # vim
    "config/nvim": ".config/nvim",
    # touchegg
    "config/touchegg": ".config/touchegg",
    # home
    "home": "",
    # python
    "ipython/profile_default": ".ipython/profile_default",
    "ipython/profile_default---startup": ".ipython/profile_default/startup",
    "matplotlib": ".matplotlib",
    # oh-my-zsh
    "oh-my-zsh/custom": ".oh-my-zsh/custom",
    "oh-my-zsh/custom--themes": ".oh-my-zsh/custom/themes",
}

REPO_ROOT_DIR: Path = Path(__file__).resolve().parent


def backup_name(path: Path) -> Path:
    """
    Append a timestamp suffix to create a unique backup path.
    """
    timestamp = str(datetime.datetime.now()).replace(" ", "_")
    return Path(f"{path}.dotfiles_backup_{timestamp}")


def create_link(in_path: Path, real_path: Path, dry: bool = False) -> None:
    """
    Symlink in_path at real_path, backing up any existing target first.

    Skips if real_path is already a symlink (even if pointing elsewhere).
    """
    in_path = Path(in_path)
    real_path = Path(real_path)
    print(in_path)

    if real_path.is_symlink():
        print("  already a link: {}\n".format(real_path))
        return

    if real_path.exists():
        backup_path = backup_name(real_path)
        verb = "would back up" if dry else "backing up"
        print("  {}:\n  {} to {}".format(verb, real_path, backup_path))
        if not dry:
            real_path.rename(backup_path)

    verb = "would create symlink" if dry else "creating symlink"
    print("  {}:\n  {} -> {}".format(verb, real_path, in_path))
    if not dry:
        real_path.symlink_to(in_path)
    print()

def ensure_dir(dirname: Path) -> None:
    """
    Create dirname and parents if they don't already exist.
    """
    Path(dirname).mkdir(parents=True, exist_ok=True)


def handle_dir(src: Path, dest: Path, dry: bool = False) -> None:
    """
    Symlink every entry from src into dest, sorted alphabetically.
    """
    src = Path(src)
    dest = Path(dest)
    if dry:
        if not dest.exists():
            print("  would create directory: {}".format(dest))
    else:
        ensure_dir(dest)
    for item in sorted(src.iterdir()):
        create_link(item, dest / item.name, dry=dry)


def main(dest: Path = Path.home(), dry: bool = False) -> None:
    """
    Install all dotfiles by symlinking each source dir under dest.
    """
    dest = Path(dest).expanduser()
    for src_name, dest_name in BASE_INSTALL_DIRS.items():
        src = REPO_ROOT_DIR / src_name
        install_dest = dest / dest_name
        handle_dir(src, install_dest, dry=dry)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Install dotfiles")
    _ = parser.add_argument(
        "--dry",
        default=False,
        action="store_true",
        help="dry run (no filesystem changes)",
    )
    _ = parser.add_argument(
        "--dest",
        default=Path.home(),
        type=Path,
        help="installation root (default: $HOME)",
    )
    args = parser.parse_args()
    main(dest=args.dest, dry=args.dry)
