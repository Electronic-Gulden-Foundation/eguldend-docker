#!/bin/bash

set -e

if [ ! -e "$HOME/.egulden/coin.conf" ]; then
  mkdir -p "$HOME/.egulden"

  echo "Creating coin.conf"

  cat <<EOF >"$HOME/.egulden/coin.conf"
rpcuser=${RPCUSER:-eguldenrpc}
rpcpassword=${RPCPASSWORD:-$(dd if=/dev/urandom bs=33 count=1 2>/dev/null | base64)}
printtoconsole=1
EOF
fi

cat "$HOME/.egulden/coin.conf"

chown -R egulden:egulden "$HOME"
echo -n "Executing: "
su -c "${@:1}" - egulden
