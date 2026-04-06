if status is-interactive
    if not ssh-add -l >/dev/null 2>&1
        eval (ssh-agent -c) >/dev/null
    end

    ssh-add ~/.ssh/id_ed25519 2>/dev/null
end
