namespace :nix do
  desc "format configuration"
  task :format do
    sh('nix fmt')
  end

  namespace :flake do
    desc "update nix flake.lock"
    task :update do 
      sh('nix flake update')
    end

    desc "check nix flakes & configurations for current system"
    task :check do
      sh('nix flake check')
    end

    namespace :check do
      desc "check nix flakes & configurations for all systems"
      task :all do
        sh('nix flake check --all-systems')
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

    desc "rebuild & install nixos configuration"
    task :install do
      sh("nixos-rebuild switch --flake '.' --sudo --impure -j 8")
    end
  end

  namespace :home do
    desc "rebuild home manager configuration"
    task :build do
      sh("nix build --impure './nixos#homeConfigurations.\"#{ENV["USER"]}\".activationPackage'")
    end

    desc "rebuild & install home-manager config"
    task :install do
      sh("home-manager switch --impure --flake '.' -j 8")
    end

    namespace :install do
      desc "rebuild & install home-manager config offline"
      task :offline do
        sh("home-manager switch --impure --option substitute false --flake '.' -j 8")
      end

      desc "rebuild & install home-manager config and backup replaced files"
      task :backup do
        sh("home-manager switch --impure --flake '.' -j 8 -b backup")
      end

      namespace :offline do
        desc "rebuild & install home-manager config offline and backup replaced files"
        task :backup do
          sh("home-manager switch --impure --option substitute false --flake '.' -j 8 -b backup")
        end
      end
    end
  end
end

namespace :arch do
  desc "archive packages from arch/aur/flatpak/cargo"
  task :archive do
    sh('./bin/archive-packages')
  end

  desc "restore packages from arch/aur/flatpak/cargo"
  task :restore do
    sh('./bin/restore-packages')
  end
end
