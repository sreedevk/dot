#!/usr/bin/env zsh

mkdir /tmp/.trash
mv ~/.dot/.git-crypt /tmp/.trash/
mv ~/.dot/nixos/secrets/secrets.json /tmp/.trash/
git rm --cached -r ~/.dot/nixos/secrets/secrets.json

echo "{}" > ~/.dot/nixos/secrets/secrets.json

git add .
git commit -m "removed user specific secrets"
