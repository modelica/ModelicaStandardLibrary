#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
Copyright (C) 2021, Modelica Association and contributors
All rights reserved.

Check for deprecated Text.lineColor annotation
python check_deprecated_line_color.py [path...]
'''

import os
import re
import sys

PATTERN = re.compile(r'(Text\s*\([^\).]*)lineColor')

def _checkDeprecatedFileLineColor(file_name):
    errors = 0
    with open(file_name, 'r') as file:
        lines = file.readlines()
    line_pos = [0]
    n_lines = len(lines)
    for i in range(n_lines):
        line_pos.append(line_pos[-1] + len(lines[i]))
    for match in PATTERN.finditer(''.join(lines)):
        print('File "{0}": line {1} - Warning: Deprecated Text.'
            'lineColor annotation. Use Text.textColor.'.format(
            file_name, next(i for i in range(n_lines) if line_pos[i] > match.start(1))))
        errors = errors + 1
    return errors

def _walkCheck(func, path):
    error_count = 0
    for subdir, _, files in os.walk(path):
        for file in files:
            if os.path.splitext(file)[1] == '.mo':
                file_name = os.path.join(subdir, file)
                error_count = error_count + func(file_name)
    return error_count

def checkDeprecatedLineColor(path):
    if os.path.isdir(path):
        return _walkCheck(_checkDeprecatedFileLineColor, path)
    elif os.path.isfile(path):
        return _checkDeprecatedFileLineColor(path)
    else:
        return 1

if __name__ == '__main__':
    module_dir = os.path.split(__file__)[0]
    if len(sys.argv) == 1:
        paths = (os.path.realpath(module_dir), )
    elif len(sys.argv) > 1:
        paths = sys.argv[1:]

    error_count = 0
    for path in paths:
        error_count = error_count + checkDeprecatedLineColor(path)
    sys.exit(error_count)
