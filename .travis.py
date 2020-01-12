#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
Copyright (C) 2020, Modelica Association and contributors
All rights reserved.

Check Modelica HTML documentation for validity
python .travis.py [check_function] [path]
'''

import re
import os
import os.path
import sys

from tidylib import tidy_document

# See https://html.spec.whatwg.org/#void-elements
void_tags = ('area', 'base', 'br', 'col', 'embed', 'hr', 'img', 'input', 'keygen', 'link', 'menuitem', 'meta', 'param', 'source', 'track', 'wbr')

# Tags that should not be used
avoidable_tags = ('b', 'i', 'h1', 'h2', 'h3', 'figure', 'figcaption')

# See https://haacked.com/archive/2004/10/25/usingregularexpressionstomatchhtml.aspx/
pattern = re.compile(r'</?\w+((\s+\w+(\s*=\s*(?:\\"(.|\n)*?\\"|\'(.|\n)*?\'|[^\'">\s]+))?)+\s*|\s*)/?>', re.IGNORECASE)

# HTML Tidy IDs to be ignored
ignore_ids = ('MISSING_ATTRIBUTE', 'MISMATCHED_ATTRIBUTE_WARN', 'REMOVED_HTML5', 'MISSING_QUOTEMARK_OPEN')

# HTML Tidy options
tidy_options = {'doctype': 'omit', 'show-body-only': 1, 'show-warnings': 1, 'show-info': 1, 'mute-id': 1}

def checkHTML(file_name):
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
    with open(file_name) as file:
        stack = []
        i = 1
        for line in file:
            for match in pattern.finditer(line):
                tag = match.group(0)
                tag = tag.strip('< >')
                tag = tag.split(' ')[0]
                if bool(stack):
                    if tag.lower() in avoidable_tags:
                        found_invalid.append((i, tag))
                    if tag != tag.lower():
                        found_case.append((i, tag))
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
                elif tag[0] != '/' and tag not in void_tags:
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

    return len(found_mismatch) + len(found_invalid) + len(found_case)

def _tidyHTML(doc):
    body = ''.join(doc)
    body = body.replace('\\"', '"')

    _, errors = tidy_document(r'{0}'.format(body), options=tidy_options)

    error_list = errors.rstrip().split('\n')
    errors = []
    for error in error_list:
        error = error.rstrip().split('\n')
        for err in error:
            if err is not '' and not any(id in err for id in ignore_ids):
                errors.append(err)

    return errors

def tidyHTML(file_name):
    """
    Run HTML Tidy on each HTML documentation found in file_name

    Known issue: Single line HTML documentation is erroneously detected as error
    """
    errors = []
    with open(file_name) as file:
        in_doc = False
        doc = []
        i = 1
        for line in file:
            if in_doc:
                doc.append(line)
            for match in pattern.finditer(line):
                tag = match.group(0)
                tag = tag.strip('< >')
                tag = tag.split(' ')[0]
                if tag == 'html':
                    # Fill with empty lines to get matching line numbers from HTML Tidy
                    doc = ['\n']*(i - 1)
                    doc.append(line[match.span()[1]:])
                    in_doc = True
                elif tag == '/html':
                    del doc[-1]
                    doc.append(line[:match.span()[0]])
                    # Call HTML Tidy
                    errors = errors + _tidyHTML(doc)
                    in_doc = False
            i = i + 1

    # Debug print
    for error in errors:
        print('File "{0}": {1}'.format(file_name, error))

    return len(errors)

def _walkCheck(func, path):
    error_count = 0
    for subdir, _, files in os.walk(path):
        for file in files:
            if os.path.splitext(file)[1] == '.mo':
                file_name = os.path.join(subdir, file)
                error_count = error_count + func(file_name)
    return error_count

def _runCheck(func, path):
    if os.path.isdir(path):
        return _walkCheck(func, path)
    elif os.path.isfile(path):
        return func(path)
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
        error_count = _runCheck(check_function, path)
    except KeyError:
        print('Invalid check function "{0}" called. Only "checkHTML" and "tidyHTML "are implemented.'.format(function))
        error_count = 1

    sys.exit(error_count)
