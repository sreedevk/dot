# frozen_string_literal: true

namespace :archlinux do
  desc 'archive package information'
  task :archive_packages do
    sh('pacman -Qe > ~/.dot/archlinux/packages.txt')
    sh("cargo install --list | grep ':' | sed 's/://g' > ~/.dot/archlinux/cargo.txt")
  end

  desc 'restore packages'
  task :restore_packages do
    sh('pacman -S - < ~/.dot/archlinux/packages.txt')
    `cat ~/.dot/archlinux/cargo.txt`
      .lines
      .lazy
      .map(&:strip)
      .map  { |pkg| pkg.split(' ')[0] }
      .each { |pkg| sh("cargo install #{pkg}") }
  end
end

namespace :nixos do
  desc 'rebuild system'
  task :rebuild do
    sh("sudo nixos-rebuild switch --flake ./nixos##{`cat /etc/hostname`.strip}")
  end
end
