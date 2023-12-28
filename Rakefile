namespace :packages do
  desc "Update Installed Packages Information"
  task :archive do
    # backup pacman packages
    sh("pacman -Qe > ~/.dot/.pkglists.txt")

    # backup cargo packages
    sh("cargo install --list | grep ':' | sed 's/://g' > ~/.dot/.cargo_pkglists.txt")
  end
end
