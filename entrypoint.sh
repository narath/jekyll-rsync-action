#!/bin/sh

# actions mounts $GITHUB_WORKSPACE, so available in our container...
BUILD_DIR=$GITHUB_WORKSPACE/_site

# concat destination variables for rsync DEST
DEST=$DEST_USERNAME@$DEST_HOST:$DEST_PATH 

SSH_KEY_PATH=$HOME/.ssh/id_rsa

# assuming site source present in GITHUB_WORKSPACE, build into default _site
chmod -R a+w $GITHUB_WORKSPACE
cd $GITHUB_WORKSPACE
jekyll build --trace

# assign private key from secrets to SSH_KEY via workflow file
# use SSH_KEY to configure private key
mkdir -p $HOME/.ssh
echo $SSH_KEY > $SSH_KEY_PATH
chmod 600 $SSH_KEY_PATH

# deploy built jekyll site w/ rsync
echo "source: $BUILD_DIR"  
echo "dest: $DEST"
rsync -avz "$BUILD_DIR"  "$DEST"
