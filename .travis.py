#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
Copyright (C) 2019, Modelica Association and contributors
All rights reserved.

Check Modelica HTML documentation for tag validity
python .travis.py checkHTML fileOrDirectory
'''

import re
import os
import os.path
import sys

# See https://html.spec.whatwg.org/#void-elements
void_tags = ('area', 'base', 'br', 'col', 'embed', 'hr', 'img', 'input', 'keygen', 'link', 'menuitem', 'meta', 'param', 'source', 'track', 'wbr')

# See https://haacked.com/archive/2004/10/25/usingregularexpressionstomatchhtml.aspx/
pattern = re.compile(r'</?\w+((\s+\w+(\s*=\s*(?:\\"(.|\n)*?\\"|\'(.|\n)*?\'|[^\'">\s]+))?)+\s*|\s*)/?>')

def _checkHTMLFile(fileName):
    errors = []
    with open(fileName) as file:
        stack = []
        i = 1
        for line in file:
            for match in pattern.finditer(line):
                error = False
                tag = match.group(0)
                tag = tag.strip('< >')
                tag = tag.split(' ')[0]
                # print(i, tag, stack)
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
                    errors.append((i, tag))
            i = i + 1

    # Debug print
    for i, tag in errors:
        print('HTML tag "{2}" mismatch in file "{0}":{1}'.format(fileName, i, tag))

    return len(errors)

def _checkHTMLDirectory(dir):
    errorCount = 0
    for subdir, dirs, files in os.walk(dir):
        for file in files:
            if os.path.splitext(file)[1] == '.mo':
                fileName = os.path.join(subdir, file)
                errorCount = errorCount + _checkHTMLFile(fileName)
    return errorCount

def checkHTML(path):
    if os.path.isdir(path):
        return _checkHTMLDirectory(path)
    elif os.path.isfile(path):
        return _checkHTMLFile(path)
    else:
        return 1

if __name__ == '__main__':
    if len(sys.argv) == 3:
        function = sys.argv[1]
        path = sys.argv[2]
        errorCount = globals()[function](path)
    else:
        errorCount = 1

    sys.exit(errorCount)
