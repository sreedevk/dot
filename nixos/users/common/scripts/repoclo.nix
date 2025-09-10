{ pkgs, ... }:
pkgs.writeShellScriptBin "repoclo" ''
  read -p "Enter Git repository URL: " url
  [ -z "$url" ] && exit 1

  repo_dir="$HOME/Data/repositories/$(basename -s .git "$url")"
  git clone "$url" "$repo_dir" 2>/dev/null || {
      echo "Error cloning repository. Check the URL or directory permissions."
      exit 1
  }

  zoxide add "$repo_dir" && echo "Added to zoxide: $repo_dir" || {
      echo "Error adding to zoxide. Ensure zoxide is installed."
      exit 1
  }

  read -n 1 -s -r -p "Press any key to close..."
''
