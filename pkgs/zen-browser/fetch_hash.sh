#! /usr/bin/env nix-shell
#! nix-shell -i bash -p curl jq nix gnused

latest_version=$(curl -s https://api.github.com/repos/zen-browser/desktop/releases/latest | jq -r '.tag_name')
base_url="https://github.com/zen-browser/desktop/releases/download/${latest_version}"
file="zen.linux-x86_64.tar.xz"

echo 'Updating version in default.nix'
sed -Ei "s/rev = \"(.*)\"/rev = \"${latest_version}\"/g" default.nix

url="${base_url}/${file}"
echo "Updating hash for ${url}"
rev=$(nix-prefetch-url --type sha256 ${url})
sed -Ei "s/linux_x86_64-hash = \"(.*)\"/linux_x86_64-hash = \"${rev}\"/g" default.nix