#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
Copyright (C) 2018-2024, Modelica Association and contributors
All rights reserved.

Generate MSL release notes from closed GitHub issues:
python Generate-ReleaseNotes.py [milestone_number] [version_string]
'''

from collections import defaultdict
from enum import IntEnum
import json
import os
import re
import sys

import docraptor
import jinja2
import markdown
import requests
import yaml

IssueType = IntEnum(
    value='IssueType',
    names=[
        ('Bugs', 1),
        ('Enhancements', 2),
        ('Examples', 3),
        ('Documentation', 4),
        ('Miscellaneous', 5)
    ]
)

def main(dir, milestone, version, auth):
    owner = 'modelica'
    repo = 'ModelicaStandardLibrary'
    html_template = 'Modelica-ReleaseNotes-Template.html'

    # Filter closed issues (including pull requests) on milestone in ascending order
    p = {'state': 'closed', 'milestone': milestone, 'page': 1, 'per_page': 100, 'direction': 'asc'}
    url = 'https://api.github.com/repos/{0}/{1}/issues'.format(owner, repo)
    r = requests.get(url, params=p, auth=auth)
    data = json.loads(r.text or r.content)
    if not isinstance(data, list):
        print(data)
        return
    issues = defaultdict(lambda: defaultdict(list))
    cntTotal = 0
    cntPR = 0

    while True:
        for issue in data:
            cntTotal = cntTotal + 1
            if 'pull_request' in issue:
                cntPR = cntPR + 1
            labels = [l['name'] for l in issue['labels']]
            # Escape asterisk
            for i, l in enumerate(labels):
                if l == 'L: Complex*':
                    labels[i] = 'L: Complex\*'
                    break
            # Exclude regression issues
            if any(l.startswith('V: {0}'.format(version)) for l in labels):
                continue
            t = issue['title']
            t = t.replace('<', '&lt;')
            t = t.replace('>', '&gt;')
            t = t.replace('≥', '>=')
            n = issue['number']
            url = issue['html_url']
            # Mark pull requests
            if 'pull_request' in issue:
                t = '(PR) ' + t
            if 'example' in labels:
                issueType = IssueType.Examples
            elif 'documentation' in labels:
                issueType = IssueType.Documentation
            elif 'bug' in labels:
                issueType = IssueType.Bugs
            elif 'enhancement' in labels:
                issueType = IssueType.Enhancements
            else:
                issueType = IssueType.Miscellaneous
            # Introduce generic label if there was not any library related label
            if not any(l.startswith('L: ') for l in labels):
                labels.append('L: --MSL-general--')
            labels = (l for l in labels if l.startswith('L: '))
            for l in labels:
                issues[l][issueType].append((t, n, url))
        if 'next' in r.links:
            r = requests.get(r.links['next']['url'], auth=auth)
            data = json.loads(r.text or r.content)
            if not isinstance(data, list):
                print(data)
                return
        else:
            break

    path = os.path.join(dir, 'Version-{0}'.format(version))
    os.makedirs(path, exist_ok=True)
    # Write Markdown
    with open(os.path.join(path, 'ResolvedGitHubIssues.md'), 'w') as f:
        url = 'https://github.com/{0}/{1}/milestone/{2}'.format(owner, repo, milestone)
        f.write('# GitHub issues resolved for v{0}\n\n'.format(version))
        f.write('As part of this release {0} [issues]({1}) (including {2} pull requests (PR)) were closed.\n\n'.format(cntTotal, url, cntPR))
        pattern = r'[\#\1](https://github.com/{0}/{1}/issues/\1)'.format(owner, repo)
        for label, data in sorted(issues.items()):
            f.write('## {0}\n\n'.format(label[3:]))
            for issueType, issue in sorted(data.items()):
                f.write('### {0}\n\n'.format(issueType.name))
                for t, n, url in issue:
                    t = re.sub('#(\d+)', pattern, t)
                    f.write("* [\#{1}]({2}) {0}\n".format(t, n, url))
                f.write('\n')

    # Read again Markdown
    with open(os.path.join(path, 'ResolvedGitHubIssues.md'), 'r') as f:
        md = f.read()

    # Convert Markdown -> HTML
    with open(os.path.join(dir, html_template), 'r') as f:
        template = f.read()
    html = jinja2.Template(template).render(
        content=markdown.markdown(md),
        title='MSL {0} GitHub issues'.format(version))
    with open(os.path.join(path, 'ResolvedGitHubIssues.html'), 'w') as f:
        f.write(html)

    # Convert Markdown -> PDF
    doc_api = docraptor.DocApi()
    doc_api.api_client.configuration.username = os.getenv('DOCRAPTOR_API_KEY', default='YOUR_API_KEY_HERE')
    try:
        pdf = doc_api.create_doc({
            'test': yaml.load(os.getenv('DOCRAPTOR_TEST', default='True'), yaml.SafeLoader),
            'name': 'ResolvedGitHubIssues.pdf',
            'document_content': html,
            'document_type': 'pdf'})
        with open(os.path.join(path, 'ResolvedGitHubIssues.pdf'), 'wb') as f:
            f.write(pdf)
    except docraptor.rest.ApiException as e:
        print(e.status)
        print(e.reason)
        print(e.body)


if __name__ == '__main__':
    module_dir, module_name = os.path.split(__file__)
    if len(sys.argv) == 1:
        milestone = 4
        version = '4.0.0'
    elif len(sys.argv) == 2:
        milestone = sys.argv[1]
        version = '4.0.0'
    elif len(sys.argv) > 2:
        milestone = sys.argv[1]
        version = sys.argv[2]

    # Specify user authorization in case of exceeded rate limit
    # auth = ('user name', 'access token') or ('client id', 'client secret')
    auth = None
    main(module_dir, milestone, version, auth)
