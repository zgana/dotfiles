#!/usr/bin/env -S uv run


import datetime
from pathlib import Path


base_install_dirs: dict[str, str] = {
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

home: Path = Path.home()
this_dir: Path = Path(__file__).resolve().parent
install_dirs: dict[Path, Path] = {
    this_dir / k: home / v for (k, v) in base_install_dirs.items()
}


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
    print(real_path)
    if real_path.is_symlink():
        print("already a link:\n{}\n".format(real_path))
        return
    if real_path.exists():
        backup_path = backup_name(real_path)
        print("backing up:\n{} to {}".format(real_path, backup_path))
        if not dry:
            real_path.rename(backup_path)
    print("creating symlink:\n{} -> {}".format(real_path, in_path))
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
    ensure_dir(dest)
    for item in sorted(src.iterdir()):
        create_link(item, dest / item.name, dry=dry)


def main() -> None:
    """
    Install all dotfiles by symlinking each source dir into $HOME.
    """
    # loop over install dirs
    for src, dest in install_dirs.items():
        handle_dir(src, dest, dry=False)


if __name__ == "__main__":
    main()
