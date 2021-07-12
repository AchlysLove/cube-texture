#!/user/bin/env sh

set -e

npm run build

cd dist

git init
git add -A
git commit -m "new deployment"
git push -f git@github.com:AchlysLove/cube-texture.git master:gh-pages

cd -

