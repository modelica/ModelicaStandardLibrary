#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
Copyright (C) 2020, Modelica Association and contributors
All rights reserved.

Check Modelica HTML documentation for link validity
'''

import re
import os
try:
    import urllib2
except ImportError:
    import urllib.request as urllib2
import ssl

from concurrent.futures import ProcessPoolExecutor as PoolExecutor

# See https://haacked.com/archive/2004/10/25/usingregularexpressionstomatchhtml.aspx/
PATTERN = re.compile(r'</?\w+((\s+\w+(\s*=\s*(?:\\"(.|\n)*?\\"|\'(.|\n)*?\'|[^\'">\s]+))?)+\s*|\s*)/?>',
    re.IGNORECASE)

def _getFileURLs(file_name):
    urls = []
    with open(file_name) as file:
        i = 1
        for line in file:
            for match in PATTERN.finditer(line):
                tag = match.group(0)
                tag = tag.strip('< >')
                if tag.split(' ')[0].lower() != 'a':
                    continue
                url = re.search(r'(?<=href=\\")http.*?(?=\\")', tag)
                if url is None:
                    continue
                url = url.group(0)
                if url in urls:
                    continue
                urls.append(url)
            i = i + 1
    return {file_name: urls}

def _getURLs(path):
    urls = {}
    for subdir, _, files in os.walk(path):
        for file in files:
            if os.path.splitext(file)[1] == '.mo':
                file_name = os.path.join(subdir, file)
                urls.update(_getFileURLs(file_name))
    return urls

def _checkURL(url):
    try:
        rc = urllib2.urlopen(url).getcode()
        return (url, rc)
    except:
        pass
    try:
        headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Win64; x64)'}
        rc = urllib2.urlopen(urllib2.Request(url, None, headers), context=ssl._create_unverified_context()).getcode()
    except urllib2.HTTPError as e:
        rc = e.code
        if rc == 429:
            # Ignore too many requests
            rc = 200
        elif rc in (301, 302):
            # Handle redirect errors
            rc = urllib2.build_opener(urllib2.HTTPCookieProcessor).open(url).code
    except:
        rc = 0
    return (url, rc)

def checkLinks(path):
    if os.path.isdir(path):
        urls = _getURLs(path)
    elif os.path.isfile(path):
        urls = _getFileURLs(path)
    else:
        return 1

    all_urls = set()
    for url_list in urls.values():
        all_urls.update(url_list)

    errors = 0
    with PoolExecutor(max_workers=8) as executor:
        for url, rc in executor.map(_checkURL, all_urls):
            if rc != 200:
                errors = errors + 1
                # Only get first match for file name
                file_name = next(file_name for file_name, url_list in urls.items() if url in url_list)
                print('File "{0}": Error {1}for URL "{2}"'.format(file_name, '' if rc == 0 else str(rc) + ' ', url))
    return errors
