namespace :packages do
  desc "Update Installed Packages Information"
  task :archive do
    # backup pacman packages
    sh("pacman -Qe > ~/.dot/.pkglists.txt")

    # backup cargo packages
    sh("cargo install --list | grep ':' | sed 's/://g' > ~/.dot/.cargo_pkglists.txt")

    # backup nix packages
    sh("nix-env -q --installed > ~/.dot/.nixpkgs.txt")
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
