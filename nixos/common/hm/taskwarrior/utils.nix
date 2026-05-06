rec {
  mkCoefficients =
    kind: coefficients:
    with builtins;
    concatStringsSep "\n" (
      map (
        item: "urgency.user.${kind}.${item.name}.coefficient=${toString item.coefficient}"
      ) coefficients
    );

  mkConfig =
    theme: opts: coefficients:
    let
      sync-url = if opts.taskwarrior.sync == null then "" else opts.taskwarrior.sync.serverAddress;
      sync-client-id = if opts.taskwarrior.sync == null then "" else opts.taskwarrior.sync.clientID;
      sync-enc-sec = if opts.taskwarrior.sync == null then "" else opts.taskwarrior.sync.encryptionSecret;
    in
    ''
      # THEME
      include ${theme}

      # LOCAL DATA STORAGE
      data.location=${opts.taskwarrior.dataLocation}
      hooks.location=${opts.taskwarrior.hooksLocation}

      # SYNC SETTINGS
      sync.server.url=${sync-url}
      sync.server.client_id=${sync-client-id}
      sync.encryption_secret=${sync-enc-sec}

      # COEFFICIENTS
      urgency.due.coefficient=${builtins.toString coefficients.system.due}
      urgency.blocking.coefficient=${builtins.toString coefficients.system.blocking}
      urgency.scheduled.coefficient=${builtins.toString coefficients.system.scheduled}
      urgency.active.coefficient=${builtins.toString coefficients.system.active}
      urgency.age.coefficient=${builtins.toString coefficients.system.age}
      urgency.annotations.coefficient=${builtins.toString coefficients.system.annotations}
      urgency.waiting.coefficient=${builtins.toString coefficients.system.waiting}
      urgency.blocked.coefficient=${builtins.toString coefficients.system.blocked}
      urgency.tags.coefficient=${builtins.toString coefficients.system.tags}
      urgency.project.coefficient=${builtins.toString coefficients.system.project}
      urgency.uda.priority.H.coefficient=${builtins.toString coefficients.uda.H}
      urgency.uda.priority.M.coefficient=${builtins.toString coefficients.uda.M}
      urgency.uda.priority.L.coefficient=${builtins.toString coefficients.uda.L}
      uda.taskwarrior-tui.task-report.next.filter=status:pending -WAITING limit:page -someday
      uda.taskwarrior-tui.task-report.work.filter=status:pending -WAITING limit:page -someday proj:work:tunecore
      uda.taskwarrior-tui.background_process=task sync
      uda.taskwarrior-tui.background_process_period=60
      ${mkCoefficients "project" coefficients.user.projects}
      ${mkCoefficients "tag" coefficients.user.tags}

      # VERBOSITY
      verbose=${opts.taskwarrior.verbose}
    '';
}
