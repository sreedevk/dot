namespace :archlinux do
  desc "archive package information"
  task :archive_packages do
    sh("pacman -Qe > ~/.dot/.pkglists.txt")
    sh("cargo install --list | grep ':' | sed 's/://g' > ~/.dot/.cargo_pkglists.txt")
  end

  desc "restore packages"
  task :restore_packages do
    sh("pacman -S - < ~/.dot/.pkglists.txt")
    `cat ~/.dot/.cargo_pkglists.txt`
      .lines
      .lazy
      .map(&:strip)
      .map  {|pkg| pkg.split(' ')[0] }
      .each {|pkg| sh("cargo install #{pkg}") }
  end
end

namespace :nixos do
  desc "rebuild system"
  task :rebuild do
    sh("sudo nixos-rebuild switch --flake ./nixos##{ENV['HOSTNAME']}")
  end
end
