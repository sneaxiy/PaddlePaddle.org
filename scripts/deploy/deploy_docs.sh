#!/bin/bash
set -e

DEC_PASSWD=$1
GITHUB_BRANCH=$2
SOURCE_DIR=$3

echo "Deploy docs: DEC_PASSWD:($1) GITHUB_BRANCH:($2) SOURCE_DIR:($3)"

# Pull PaddlePaddle.org app and run the deploy_documentation command
if [ $GITHUB_BRANCH == "develop_doc" ]; then
PPO_BRANCH=develop_doc
else
PPO_BRANCH=master
fi

echo "Pull PaddlePaddle.org app"
curl -LOk https://github.com/PaddlePaddle/PaddlePaddle.org/archive/$PPO_BRANCH.zip
unzip $PPO_BRANCH.zip
cd PaddlePaddle.org-$PPO_BRANCH/portal
sudo pip install --ignore-installed -r requirements.txt

mkdir documentation

# We need to set this env so the deploy script knows whether or not this
# is a local development build.
export ENV=production

echo "executing deploy_documentation"
python manage.py deploy_documentation --source_dir=$SOURCE_DIR --destination_dir=documentation $GITHUB_BRANCH

echo "Documentation generation completed"
# Display what documentation will be sync to the server
ls documentation

# Deploy to remote server by SSH'ing into it.
openssl aes-256-cbc -d -a -in ../scripts/deploy/content_mgr.pem.enc -out content_mgr.pem -k $DEC_PASSWD
eval "$(ssh-agent -s)"
chmod 400 content_mgr.pem
ssh-add content_mgr.pem
export STAGE_DEPLOY_IP=13.229.163.131

rsync -r documentation/ content_mgr@$STAGE_DEPLOY_IP:/var/pages/documentation
rsync -r menus/ content_mgr@$STAGE_DEPLOY_IP:/var/pages/menus

chmod 644 content_mgr.pem
rm -rf documentation
rm -rf menus
