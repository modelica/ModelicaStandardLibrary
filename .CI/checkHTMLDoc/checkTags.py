#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
Copyright (C) 2020, Modelica Association and contributors
All rights reserved.

Check Modelica HTML documentation for tag validity
'''

import re
import os

# See https://haacked.com/archive/2004/10/25/usingregularexpressionstomatchhtml.aspx/
PATTERN = re.compile(r'</?\w+((\s+\w+(\s*=\s*(?:\\"(.|\n)*?\\"|\'(.|\n)*?\'|[^\'">\s]+))?)+\s*|\s*)/?>',
    re.IGNORECASE)

# See https://html.spec.whatwg.org/#void-elements
VOID_TAGS = ('area', 'base', 'br', 'col', 'embed', 'hr', 'img', 'input', 'keygen', 'link', 'menuitem', 'meta', 'param', 'source', 'track', 'wbr')

# Tags that should not be used
AVOIDABLE_TAGS = ('b', 'i', 'h1', 'h2', 'h3', 'h6', 'figure', 'figcaption')

def _checkFileTags(file_name):
    """
    Check each HTML documentation found in file_name for
    - unclosed tags
    - tag case sensitivity
    - use of avoidable tags

    Known issue: Multi-line HTML tags are erroneously detected as error
    """
    found_invalid = []
    found_mismatch = []
    found_case = []
    found_inline = []
    with open(file_name) as file:
        stack = []
        i = 1
        for line in file:
            for match in PATTERN.finditer(line):
                tag = match.group(0)
                tag = tag.strip('< >')
                tag = tag.split(' ')[0]
                if bool(stack):
                    if tag.lower() in AVOIDABLE_TAGS:
                        found_invalid.append((i, tag))
                    if tag != tag.lower():
                        found_case.append((i, tag))
                if tag == 'img' and len(stack) == 1:
                    found_inline.append((i, tag))
                if tag == 'html':
                    if bool(stack):
                        found_mismatch.append((i, tag))
                        found_mismatch.append(stack[-1])
                        stack = []
                    stack.append((i, tag))
                elif tag == '/html':
                    if not bool(stack) or len(stack) != 1 or stack[-1][1] != 'html':
                        found_mismatch.append((i, tag))
                        found_mismatch.append(stack[-1])
                    stack = []
                elif tag[0] != '/' and tag not in VOID_TAGS:
                    if bool(stack):
                        stack.append((i, tag))
                elif bool(stack) and tag[0] == '/':
                    if stack[-1][1] == tag[1:]:
                        del stack[-1]
                    else:
                        found_mismatch.append((i, tag))
                        found_mismatch.append(stack[-1])
            i = i + 1
        if bool(stack):
            found_mismatch.append(stack[-1])

    # Debug print
    for i, tag in found_mismatch:
        print('File "{0}": line {1} - Warning: HTML tag "{2}" mismatch'.format(file_name, i, tag))
    for i, tag in found_invalid:
        print('File "{0}": line {1} - Warning: HTML tag "{2}" misuse.'.format(file_name, i, tag))
    for i, tag in found_case:
        print('File "{0}": line {1} - Warning: HTML tag "{2}" misspelling. Use lower case.'.format(file_name, i, tag))
    for i, tag in found_inline:
        print('File "{0}": line {1} - Warning: HTML tag "{2}" misuse. Wrap in "div" tag.'.format(file_name, i, tag))

    return len(found_mismatch) + len(found_invalid) + len(found_case) + len(found_inline)

def _walkCheck(func, path):
    error_count = 0
    for subdir, _, files in os.walk(path):
        for file in files:
            if os.path.splitext(file)[1] == '.mo':
                file_name = os.path.join(subdir, file)
                error_count = error_count + func(file_name)
    return error_count

def checkTags(path):
    if os.path.isdir(path):
        return _walkCheck(_checkFileTags, path)
    elif os.path.isfile(path):
        return _checkFileTags(path)
    else:
        return 1
