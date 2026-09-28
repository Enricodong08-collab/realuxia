#!/bin/zsh
# 发布 REALUXIA 官网：同步到新加坡服务器 + 推送 GitHub 备份
set -e
cd "$(dirname "$0")"
rsync -az --delete --exclude .git --exclude .nojekyll --exclude deploy.sh --exclude CNAME \
  -e "ssh -i $HOME/.ssh/realuxia_hk -o BatchMode=yes" ./ root@47.84.22.178:/var/www/realuxia/
ssh -i $HOME/.ssh/realuxia_hk -o BatchMode=yes root@47.84.22.178 'chown -R www-data:www-data /var/www/realuxia'
git add -A && (git commit -qm "Update site" || true) && git push -q
echo "已发布：https://www.realuxia.com"
