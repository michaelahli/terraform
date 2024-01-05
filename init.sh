
#!/usr/bin/sudo bash

source .env.script

git clone "$REPOSITORY_URL"

APP_DIR=$(basename "$REPOSITORY_URL")
mv $APP_DIR app

cp -r templates/certificates app/certificates
cp -r templates/pipeline/.harness app/.harness

pushd app

go mod tidy
git remote set-url origin "$GIT_URL"
git checkout -b main
rm .gitignore
git add . && git commit -m "define job spec"
git push origin main -f

popd
