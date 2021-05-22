#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
Copyright (C) 2020, Modelica Association and contributors
All rights reserved.

Check Modelica HTML documentation for validity
python check_html.py [check_function] [path]
'''

import importlib
import os.path
import sys

if __name__ == '__main__':
    module_dir = os.path.split(__file__)[0]
    if len(sys.argv) == 1:
        function = 'checkTags'
        path = os.path.realpath(module_dir)
    elif len(sys.argv) == 2:
        function = sys.argv[1]
        path = os.path.realpath(module_dir)
    elif len(sys.argv) > 2:
        function = sys.argv[1]
        path = sys.argv[2]

    try:
        mod = importlib.import_module('checkHTMLDoc.' + function)
        check_function = getattr(mod, function)
        error_count = check_function(path)
    except ImportError as e:
        print(str(e))
        error_count = 1

    sys.exit(error_count)
