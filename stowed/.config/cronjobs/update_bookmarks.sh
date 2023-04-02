#!/usr/bin/env zsh

app_dir=/home/sreedev/.bookmarks
cd $app_dir
BUNDLE_GEMFILE="$app_dir/Gemfile" bundle exec rake -f "$app_dir/Rakefile" bookmarks:update
