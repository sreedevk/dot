FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  curl \
  git \
  gnupg2 \
  ca-certificates \
  lsb-release \
  sudo \
  xz-utils \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash nixuser

RUN echo 'nixuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN sudo -u nixuser \
  sh -c 'curl -L https://nixos.org/nix/install | bash'

RUN mkdir -p /etc/nix

RUN echo 'experimental-features = nix-command flakes' | tee -a /etc/nix/nix.conf

ENV USER=nixuser
ENV HOME=/home/nixuser
ENV PATH=/home/nixuser/.nix-profile/bin:/home/nixuser/.nix-profile/sbin:/home/nixuser/.nix-defexpr/channels_root:/nix/var/nix/profiles/per-user/root/channels/root:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

ENV NIX_PATH=nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos

RUN mkdir -p /nix && chown nixuser /nix

USER nixuser
WORKDIR /home/nixuser

RUN /bin/bash -c 'source $HOME/.nix-profile/etc/profile.d/nix.sh && nix --version && nix-collect-garbage -d'

CMD ["/bin/bash"]
