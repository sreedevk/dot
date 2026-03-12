function __fish_rake_tasks
    rake -T 2>/dev/null | string replace -r '^rake ([^ ]+).*' '$1'
end

complete -c rake -f -a '(__fish_rake_tasks)'
