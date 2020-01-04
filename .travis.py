#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
Copyright (C) 2019, Modelica Association and contributors
All rights reserved.

Check Modelica HTML documentation for tag validity
python .travis.py [check_function] [path]
'''

import re
import os
import os.path
import sys

# See https://html.spec.whatwg.org/#void-elements
void_tags = ('area', 'base', 'br', 'col', 'embed', 'hr', 'img', 'input', 'keygen', 'link', 'menuitem', 'meta', 'param', 'source', 'track', 'wbr')

# See https://haacked.com/archive/2004/10/25/usingregularexpressionstomatchhtml.aspx/
pattern = re.compile(r'</?\w+((\s+\w+(\s*=\s*(?:\\"(.|\n)*?\\"|\'(.|\n)*?\'|[^\'">\s]+))?)+\s*|\s*)/?>', re.IGNORECASE)

def _checkHTMLFile(file_name):
    found_b = []
    found_i = []
    found_mismatch = []
    found_case = []
    with open(file_name) as file:
        stack = []
        i = 1
        for line in file:
            for match in pattern.finditer(line):
                error = False
                tag = match.group(0)
                tag = tag.strip('< >')
                tag = tag.split(' ')[0]
                # print(i, tag, stack)
                if bool(stack):
                    if tag.lower() in ('b', '/b'):
                        found_b.append((i, tag))
                    elif tag.lower() in ('i', '/i'):
                        found_i.append((i, tag))
                    if tag != tag.lower():
                        found_case.append((i, tag))
                if tag == 'html':
                    if bool(stack):
                        error = True
                        stack = []
                    stack.append((i, tag))
                elif tag == '/html':
                    if not bool(stack) or len(stack) != 1 or stack[-1][1] != 'html':
                        error = True
                    # Reset stack
                    stack = []
                elif tag[0] != '/' and tag not in void_tags:
                    if bool(stack):
                        stack.append((i, tag))
                elif bool(stack) and tag[0] == '/':
                    if stack[-1][1] == tag[1:]:
                        del stack[-1]
                    else:
                        error = True
                if error:
                    found_mismatch.append((i, tag))
            i = i + 1
        if bool(stack):
            found_mismatch.append((i, '/html'))

    # Debug print
    for i, tag in found_mismatch:
        print('HTML tag "{2}" mismatch in file "{0}":{1}'.format(file_name, i, tag))
    for i, tag in found_b:
        print('HTML tag "{2}" misuse in file "{0}":{1}. Use "strong" tag.'.format(file_name, i, tag))
    for i, tag in found_i:
        print('HTML tag "{2}" misuse in file "{0}":{1}. Use "em" tag.'.format(file_name, i, tag))
    for i, tag in found_case:
        print('HTML tag "{2}" misspelling in file "{0}":{1}. Use lower case.'.format(file_name, i, tag))

    return len(found_mismatch) + len(found_b) + len(found_i) + len(found_case)

def _checkHTMLDirectory(dir):
    error_count = 0
    for subdir, _, files in os.walk(dir):
        for file in files:
            if os.path.splitext(file)[1] == '.mo':
                file_name = os.path.join(subdir, file)
                error_count = error_count + _checkHTMLFile(file_name)
    return error_count

def checkHTML(path):
    if os.path.isdir(path):
        return _checkHTMLDirectory(path)
    elif os.path.isfile(path):
        return _checkHTMLFile(path)
    else:
        return 1

if __name__ == '__main__':
    module_dir, _ = os.path.split(__file__)
    if len(sys.argv) == 1:
        function = 'checkHTML'
        path = os.path.realpath(module_dir)
    elif len(sys.argv) == 2:
        function = sys.argv[1]
        path = os.path.realpath(module_dir)
    elif len(sys.argv) > 2:
        function = sys.argv[1]
        path = sys.argv[2]

    try:
        check_function = globals()[function]
        error_count = check_function(path)
    except KeyError:
        print('Invalid check function "{0}" called. Only "checkHTML" is implemented.'.format(function))
        error_count = 1

    sys.exit(error_count)
