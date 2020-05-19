#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
Copyright (C) 2020, Modelica Association and contributors
All rights reserved.

Check Modelica HTML documentation with HTML Tidy
'''

import re
import os

from tidylib import tidy_document

# See https://haacked.com/archive/2004/10/25/usingregularexpressionstomatchhtml.aspx/
PATTERN = re.compile(r'</?\w+((\s+\w+(\s*=\s*(?:\\"(.|\n)*?\\"|\'(.|\n)*?\'|[^\'">\s]+))?)+\s*|\s*)/?>',
    re.IGNORECASE)

# HTML Tidy IDs to be ignored
IGNORE_IDS = ('MISSING_ATTRIBUTE', 'MISMATCHED_ATTRIBUTE_WARN', 'REMOVED_HTML5')

# HTML Tidy options
TIDY_OPTIONS = {'doctype': 'omit', 'show-body-only': 1, 'show-warnings': 1, 'show-info': 1, 'mute-id': 1}

def _tidyHTML(doc):
    body = ''.join(doc)
    body = body.replace('\\"', '"')

    _, errors = tidy_document(r'{0}'.format(body), options=TIDY_OPTIONS)

    error_list = errors.rstrip().split('\n')
    errors = []
    for error in error_list:
        error = error.rstrip().split('\n')
        for err in error:
            if err is not '' and not any(id in err for id in IGNORE_IDS):
                errors.append(err)

    return errors

def _tidyFileHTML(file_name):
    """
    Run HTML Tidy on each HTML documentation found in file_name
    """
    errors = []
    with open(file_name) as file:
        in_line = 0
        doc = []
        i = 1
        for line in file:
            if in_line > 0:
                doc.append(line)
            for match in PATTERN.finditer(line):
                tag = match.group(0)
                tag = tag.strip('< >')
                tag = tag.split(' ')[0]
                tag = tag.lower()
                if tag == 'html':
                    # Fill with empty lines to get matching line numbers from HTML Tidy
                    doc = ['\n']*(i - 1)
                    doc.append(line[match.end():])
                    in_line = i
                elif tag == '/html':
                    if in_line != i:
                        del doc[-1]
                        cont = line[:match.start()]
                    else:
                        # Single line
                        cont = doc.pop()
                        cont = cont[:(match.start() - len(line))]
                    doc.append(cont)
                    # Call HTML Tidy
                    errors = errors + _tidyHTML(doc)
                    in_line = 0
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

def tidyHTML(path):
    if os.path.isdir(path):
        return _walkCheck(_tidyFileHTML, path)
    elif os.path.isfile(path):
        return _tidyFileHTML(path)
    else:
        return 1
