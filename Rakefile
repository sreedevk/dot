namespace :nix do
  namespace :os do
    namespace :offline do
      task :install do
        sh("nixos-rebuild switch --offline --flake '.' --sudo --impure -j 8")
      end
    end

    task :install do
      sh("nixos-rebuild switch --flake '.' --sudo --impure -j 8")
    end
  end

  namespace :home do
    task :build do
      sh("nix build --impure './nixos#homeConfigurations.\"#{ENV["USER"]}\".activationPackage'")
    end

    task :install do
      sh("home-manager switch --impure --flake '.' -j 8")
    end

    namespace :offline do
      task :install do
        sh("home-manager switch --impure --option substitute false --flake '.' -j 8")
      end
    end
  end
end

namespace :flake do
  task :update do 
    sh('nix flake update')
  end
  
  task :check do
    sh('nix flake check')
  end

  namespace :all do
    task :check do
      sh('nix flake check --all-systems')
    end
  end
end
