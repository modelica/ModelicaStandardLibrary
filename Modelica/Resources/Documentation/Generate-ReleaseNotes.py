#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
Copyright (C) 2018 ESI ITI GmbH
All rights reserved.

Generate MSL release notes from closed GitHub issues:
python Generate-ReleaseNotes.py [milestone_number] [version_string]
'''

import requests
import json
import re
import os
import os.path
import sys
from enum import IntEnum

IssueType = IntEnum(
    value='IssueType',
    names=[
        ('Bugs', 1),
        ('Enhancements', 2),
        ('Documentation', 3),
        ('Miscellaneous', 4)
    ]
)

def main(dir, milestone, version):
    owner = 'modelica'
    repo = 'ModelicaStandardLibrary'
    template = 'Modelica-ReleaseNotes-Template.html'

    # Filter closed issues (including pull requests) on milestone in ascending order
    p = {'state': 'closed', 'milestone': milestone, 'page': 1, 'per_page': 100, 'direction': 'asc'}
    url = 'https://api.github.com/repos/{0}/{1}/issues'.format(owner, repo)
    r = requests.get(url, params=p)
    data = json.loads(r.text or r.content)
    issues = {}
    cnt = 0

    while True:
        for issue in data:
            cnt = cnt + 1
            labels = [l['name'] for l in issue['labels']]
            # Escape asterisk
            for i, l in enumerate(labels):
                if l == 'L: Complex*':
                    labels[i] = 'L: Complex\*'
                    break
            t = issue['title']
            t = t.replace('<', '&lt;')
            t = t.replace('>', '&gt;')
            n = issue['number']
            url = issue['html_url']
            # Mark pull requests
            if 'pull_request' in issue:
                t = '(PR) ' + t
            issueType = IssueType.Miscellaneous
            if 'bug' in labels:
                issueType = IssueType.Bugs
            elif 'enhancement' in labels:
                issueType = IssueType.Enhancements
            elif 'documentation' in labels:
                issueType = IssueType.Documentation
            # Introduce generic label if there was not any library related label
            if not any(l.startswith('L: ') for l in labels):
                labels.append('L: --MSL-general--')
            for l in labels:
                if l.startswith('L: '):
                    if l in issues:
                        if issueType in issues[l]:
                            issues[l][issueType].append((t, n, url))
                        else:
                            issues[l][issueType] = [(t, n, url)]
                    else:
                        issues[l] = {issueType: [(t, n, url)]}
        if 'next' in r.links:
            r = requests.get(r.links['next']['url'])
            data = json.loads(r.text or r.content)
        else:
            break

    path = os.path.join(dir, 'Version-{0}'.format(version))
    os.makedirs(path, exist_ok=True)
    # Write Markdown
    with open(os.path.join(path, 'ResolvedGitHubIssues.md'), 'w') as f:
        url = 'https://github.com/{0}/{1}/milestone/{2}'.format(owner, repo, milestone)
        f.write('# GitHub issues resolved for v{0}\n'.format(version))
        f.write('As part of this release {0} [issues]({1}) were closed.\n\n'.format(cnt, url))
        pattern = r'[\#\1](https://github.com/{0}/{1}/issues/\1)'.format(owner, repo)
        for label, data in sorted(issues.items()):
            f.write('## {0}\n'.format(label[3:]))
            for issueType, issue in sorted(data.items()):
                f.write('### {0}\n'.format(issueType.name))
                for t, n, url in issue:
                    t = re.sub('#(\d+)', pattern, t)
                    f.write("* [\#{1}]({2}) {0}\n".format(t, n, url))
                f.write('\n')

    with open(os.path.join(path, 'ResolvedGitHubIssues.md'), 'r') as f:
        content = f.read()

    # Convert Markdown -> HTML
    with open(os.path.join(path, 'ResolvedGitHubIssues.html'), 'wb') as f:
        url = 'http://c.docverter.com/convert'
        title = 'MSL {0} GitHub issues'.format(version)
        r = requests.post(url, data={'to':'html', 'from':'markdown', 'template':template, 'title':title}, files={'input_files[]': open(os.path.join(path, 'ResolvedGitHubIssues.md'), 'rb'), 'other_files[]': open(os.path.join(dir, template), 'rb')})
        f.write(r.content)

    # Convert Markdown -> PDF
    with open(os.path.join(path, 'ResolvedGitHubIssues.pdf'), 'wb') as f:
        url = 'http://c.docverter.com/convert'
        r = requests.post(url, data={'to':'pdf', 'from':'markdown', 'template':template}, files={'input_files[]': open(os.path.join(path, 'ResolvedGitHubIssues.md'), 'rb'), 'other_files[]': open(os.path.join(dir, template), 'rb')})
        f.write(r.content)

if __name__ == '__main__':
    module_dir, module_name = os.path.split(__file__)
    if len(sys.argv) == 1:
        milestone = 12
        version = '3.2.3'
    elif len(sys.argv) == 2:
        milestone = sys.argv[1]
        version = '3.2.3'
    elif len(sys.argv) > 2:
        milestone = sys.argv[1]
        version = sys.argv[2]

    main(module_dir, milestone, version)
