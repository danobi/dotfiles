#!/bin/bash
#
# Script to respin a feature branch.

set -eu

current_branch=$(git symbolic-ref --short HEAD)
if [[ $current_branch =~ (.*)-v([0-9]+)$ ]]; then
    # Branch has a version suffix
    base_name="${BASH_REMATCH[1]}"
    current_version="${BASH_REMATCH[2]}"
    new_version=$((current_version + 1))
else
    # Branch doesn't have a version suffix
    base_name="$current_branch"
    new_version=2
fi

new_branch="${base_name}-v${new_version}"
git switch -c "$new_branch"

# Copy the description to the new branch
description=$(git description "$current_branch")
if [ -n "$description" ]; then
    git config "branch.$new_branch.description" "$description"
fi
