namespace :packages do
  desc "Update Installed Packages Information"
  task :archive do
    # backup pacman packages
    sh("pacman -Qe > ~/.dot/.pkglists.txt")

    # backup cargo packages
    sh("cargo install --list | grep ':' | sed 's/://g' > ~/.dot/.cargo_pkglists.txt")
  end

  desc "install deps"
  task :restore do
    puts "Installing pacman dependencies"
    sh("pacman -S - < ~/.dot/.pkglists.txt")
    `cat ~/.dot/.cargo_pkglists.txt`
      .lines
      .lazy
      .map(&:strip)
      .map  {|pkg| pkg.split(' ')[0] }
      .each {|pkg| sh("cargo install #{pkg}") }
  end
end

# NixOS Specific
namespace :sys do
  desc "system backup" 
  task :archive do
    sh("sudo cp /etc/nixos/*.nix ~/.dot/nixos/hosts/nullptrderef1/")
  end

  desc "system restore"
  task :restore do
    sh("sudo nixos-rebuild switch --flake ./nixos#nullptrderef1")
  end
end
