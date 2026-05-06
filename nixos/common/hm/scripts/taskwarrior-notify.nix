{ pkgs, ... }:
pkgs.writeShellScriptBin "taskwarrior-notify-due" ''
  export DISPLAY=:1
  tasks_due_soon=$(task due:+1h -ACTIVE list --format '{id}: {description}' 2>/dev/null)

  if [ -n "$tasks_due_soon" ]; then
      notify-send -a "taskwarrior" -u critical -c tasks -w 'The following tasks are due in the next hour:'$'\n'"$tasks_due_soon"
  fi
''
