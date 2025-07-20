namespace :nix do
  namespace :os do
    namespace :offline do
      desc "rebuild & install nixos configuration offline"
      task :install do
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

    namespace :offline do
      desc "rebuild & install home-manager config offline"
      task :install do
        sh("home-manager switch --impure --option substitute false --flake '.' -j 8")
      end
    end
  end
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

  namespace :all do
    desc "check nix flakes & configurations for all systems"
    task :check do
      sh('nix flake check --all-systems')
    end
  end
end
