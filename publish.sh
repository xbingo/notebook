rm -rf docs
cp -r _book docs
git add .
git commit -m $1
git push -u origin master