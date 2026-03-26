#!/bin/bash
cd /shared_data/repos/pr_testing/ModelicaStandardLibrary

# clean up repositiory from previous attempts/prs
git stash
git clean -fd
pr_number=$1

# checkout the PR
git pull https://github.com/modelica/ModelicaStandardLibrary/ pull/$pr_number/head:PR_$pr_number
git checkout PR_$pr_number

# get the current hash and print it (for manual checks)
new_hash=$(git rev-parse HEAD)
echo $new_hash