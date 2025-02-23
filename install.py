#!/usr/bin/env -S uv run


import datetime
import errno
import os
import re
from glob import glob


base_install_dirs = {
    # ghostty
    "config/ghostty": ".config/ghostty",
    # vim
    "config/nvim": ".config/nvim",
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

home = os.getenv("HOME")
this_dir = os.path.abspath(os.path.dirname(__file__))
install_dirs = {
    f"{this_dir}/{k}": f"{home}/{v}" for (k, v) in base_install_dirs.items()
}


def backup_name(path):
    timestamp = str(datetime.datetime.now())
    timestamp = re.sub(" ", "_", timestamp)
    return "{}.dotfiles_backup_{}".format(path, timestamp)


def create_link(in_path, real_path, dry=False):
    print(in_path)
    print(real_path)
    # if it's already a link, move on
    if os.path.islink(real_path):
        print("already a link:\n{}\n".format(real_path))
        return
    # if it exists, create backup
    if os.path.exists(real_path):
        backup_path = backup_name(real_path)
        print("backing up:\n{} to {}".format(real_path, backup_path))
        if not dry:
            os.rename(real_path, backup_path)
    # create link
    print("creating symlink:\n{} -> {}".format(real_path, in_path))
    if not dry:
        os.symlink(in_path, real_path)
    print()


def ensure_dir(dirname):
    """Make sure ``dirname`` exists and is a directory."""
    if not os.path.isdir(dirname):
        try:
            os.makedirs(dirname, exist_ok=False)
        except OSError as e:
            if e.errno != errno.EEXIST:
                raise
    return dirname


def handle_dir(src, dest, dry=False):
    in_paths = sorted(glob("{}/*".format(src)) + glob("{}/.*".format(src)))
    real_paths = []
    ensure_dir(dest)
    for in_path in in_paths:
        basename = os.path.basename(in_path)
        real_path = "{}/{}".format(dest, basename)
        real_paths.append(real_path)
    # loop over install items
    for in_path, real_path in zip(in_paths, real_paths):
        create_link(in_path, real_path, dry=dry)


def main():
    # loop over install dirs
    for src, dest in install_dirs.items():
        handle_dir(src, dest, dry=False)


if __name__ == "__main__":
    main()
