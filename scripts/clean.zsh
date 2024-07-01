#!/usr/bin/env zsh

mkdir .trash
mv .git-crypt .trash/
mv nixos/secrets/*.json .trash/
git rm --cached -r nixos/secrets/*.json

touch nixos/secrets/secrets.json
git commit -am "removed user specific secrets"
