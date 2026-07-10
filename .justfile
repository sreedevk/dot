clone_for_publishing:
  git clone --no-local . /tmp/dot_public

filter_private_history:
  git filter-repo --path secrets/ --path nixos/hosts/apollo --path nixos/hosts/orion/ --path nixos/hosts/rpi4b/ --path nixos/hosts/devtechnica/ --invert-paths

prepare_for_publishing: clone_for_publishing
  cd /tmp/dot_public && just filter_private_history && git remote add origin git@github.com:sreedevk/dot

publish: prepare_for_publishing
  cd /tmp/dot_public && git push origin main --force && rm -rf /tmp/dot_public
