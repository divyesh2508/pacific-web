#!/bin/bash

# Retrieve the current branch name from Git
BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || echo "unknown")

# Store the branch name in a file for future use
echo "$BRANCH" > /tmp/branch.txt

# Output the branch name for verification
echo "Branch detected: $BRANCH"