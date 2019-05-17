#!/usr/bin/env python3

from __future__ import print_function

import datetime
from glob import glob
import os
import re
import sys


install_dirs = {
        'config/nvim': '.config/nvim',
        'home': '',
        }

home = os.getenv('HOME')
this_dir = os.path.dirname(__file__)
install_dirs = {
        '{}/{}'.format(this_dir, k): '{}/{}'.format(home, v)
        for (k,v) in install_dirs.items()}

def backup_name(path):
    timestamp = str(datetime.datetime.now())
    timestamp = re.sub(' ', '_', timestamp)
    return '{}.dotfiles_backup_{}'.format(path, timestamp)

def create_link(in_path, real_path, dry=False):
    # if it's already a link, move on
    if os.path.islink(real_path):
        print('{} is already a link'.format(real_path))
        return
    # if it exists, create backup
    if os.path.exists(real_path):
        backup_path = backup_name(real_path)
        print('backing up {} to {}'.format(real_path, backup_path))
        if not dry:
            os.rename(real_path, backup_path)
    # create link
    print('creating symlink {} -> {}'.format(real_path, in_path))
    if not dry:
        os.symlink(in_path, real_path)

# loop over install dirs
for (k, v) in install_dirs.items():
    in_paths = glob('{}/*'.format(k))
    real_paths = glob('{}/*'.format(v))
    # loop over install items
    for (in_path, real_path) in zip(in_paths, real_paths):
        create_link(in_path, real_path, dry=True)
