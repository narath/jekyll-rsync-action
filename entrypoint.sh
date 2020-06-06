#!/bin/sh -l

# assuming jekyll site source in working directory, build into default _site
cd $GITHUB_WORKSPACE
jekyll build --trace

# assuming private key existsas githubsecret, configure keys
mkdir -p $HOME/.ssh
echo \"${{ secrets.SSH_KEY }}\" > $HOME/.ssh/id_rsa
chmod 600 $HOME/.ssh/id_rsa

# using secrets, deploy built jekyll site w/ rsync
rsync -avz -e 'ssh -i $HOME/.ssh/id_rsa -o StrictHostKeyChecking=no' /srv/jekyll/_site ${{ secrets.USERNAME }}@${{ secrets.HOST }}:${{ secrets.PATH }}" 
 
© 2020 GitHub, Inc.
