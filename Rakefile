namespace :nix do
  desc "format configuration"
  task :format do
    sh('nix fmt')
  end

  namespace :deploy do
    desc "colmena deploy on host apollo"
    task :apollo do 
      sh("colmena apply --impure --on apollo")
    end
  end

  namespace :flake do
    desc "update nix flake.lock"
    task :update do 
      sh('nix flake update --commit-lock-file')
    end

    desc "check nix flakes & configurations for current system"
    task :check do
      sh('nix flake check --impure')
    end

    namespace :check do
      desc "check nix flakes & configurations for all systems"
      task :all do
        sh('nix flake check --impure --all-systems')
      end
    end
  end
  namespace :os do
    namespace :install do
      desc "rebuild & install nixos configuration offline"
      task :offline do
        sh("nixos-rebuild switch --offline --flake '.' --sudo --impure -j 8")
      end
    end

    desc "collect garbage"
    task :gc do
      sh("sudo nix-collect-garbage -d")
    end

    desc "rebuild & install nixos configuration"
    task :install do
      sh("nixos-rebuild switch --flake '.' --sudo --impure -j 8")
    end
  end

  namespace :home do
    desc "rebuild home manager configuration"
    task :build do
      sh("home-manager build --impure --flake '.##{`whoami`.strip}@#{`hostname`.strip}' -j 8")
    end

    desc "collect garbage"
    task :gc do
      sh("nix-collect-garbage -d")
    end

    desc "rebuild & install home-manager config"
    task :install do
      sh("home-manager switch --impure --flake '.##{`whoami`.strip}@#{`hostname`.strip}' -j 8")
    end

    namespace :install do
      desc "rebuild & install home-manager config offline"
      task :offline do
        sh("home-manager switch --impure --option substitute false --flake '.##{`whoami`.strip}@#{`hostname`.strip}' -j 8")
      end

      desc "rebuild & install home-manager config and backup replaced files"
      task :backup do
        sh("home-manager switch --impure --flake '.##{`whoami`.strip}@#{`hostname`.strip}' -j 8 -b backup")
      end

      namespace :offline do
        desc "rebuild & install home-manager config offline and backup replaced files"
        task :backup do
          sh("home-manager switch --impure --option substitute false --flake '.##{`whoami`.strip}@#{`hostname`.strip}' -j 8 -b backup")
        end
      end
    end
  end
end

namespace :arch do
  namespace :nix do
    desc "install using system-manager"
    task :install do
      sh("sudo $(which system-manager) switch --flake '.##{`hostname`.strip}'")
      sh("rm -f result")
    end
  end

  desc "archive packages from arch/aur/flatpak/cargo"
  task :archive do
    sh('./bin/archive-packages')
  end

  desc "restore packages from arch/aur/flatpak/cargo"
  task :restore do
    sh('./bin/restore-packages')
  end
end

namespace :scripts do
  desc "list firefox addons"
  task :list_firefox_addons do 
    sh('nix-env -f "<nur>" -qaP -A repos."rycee".firefox-addons | awk "{print $2}" | fzf')
  end
end
