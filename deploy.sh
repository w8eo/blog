#!/bin/bash
set -e

cd "$(dirname "$0")"

hugo "$@"

tar cC public/ . | ssh alpinebox '
set -e
PUBLIC_DIR=/var/www/edoxer.me/public
sudo rm -rf "$PUBLIC_DIR"/*
cat | sudo tar xC "$PUBLIC_DIR"
'

if [[ $GIT_DEPLOY ]]; then
	git push
fi

echo "Done! Your site has been deployed."

if [[ $WAIT ]]; then
  echo Press any button
  read -n1
fi
