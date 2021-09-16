#!/bin/bash

# mainブランチで比較だから HEAD^ HEAD
DIFF_FILES=(`git diff HEAD^ HEAD --name-only --relative=${1}`)

if [ ${#DIFF_FILES[@]} -eq 0 ]; then
  exit 1
else
  exit 0
fi