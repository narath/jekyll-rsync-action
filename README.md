jekyll-rsync-action
=====

Overview
----

GitHub action that:

1. builds a jekyll site in a container
	* assumes that repo dropped into `GITHUB_WORKSPACE`
	* builds into default location, `_site` with `build --trace`
2. rsyncs (over ssh) \_site to remote server

Usage
-----

1. Generate password-less key
2. Add public key to `authorized_keys` (or appropriate file for your target system)
3. Define the following secrets via your repository's settings:
	* `SSH_KEY` - private key generated from first step
	* `DEST_USERNAME` - rsync deploy user
	* `DEST_HOST` - rsync destination host name
	* `DEST_PATH` - rsync destination path
4. Add a workflow to your repo (for example, `.github/workflows/jekyll.yml`)
	```
name: Jekyll Build and Deploy

on:
  push:
    branches: [ master ]

jobs:
  build_and_deploy:
    runs-on: ubuntu-latest

    steps:
    - name: checkout
      uses: actions/checkout@v2

    - name: jekyll build and rsync
      uses: foureyes/jekyll-rsync-action@v1.1.0
      env:
        SSH_KEY: ${{ secrets.SSH_KEY }}
        DEST_USERNAME: ${{ secrets.DEST_USERNAME }}
        DEST_HOST: ${{ secrets.DEST_HOST }}
        DEST_PATH: ${{ secrets.DEST_PATH }}
```

