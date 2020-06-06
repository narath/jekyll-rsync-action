# use jekyll container
FROM jekyll/builder:latest

# copy action's startup script to container root
COPY entrypoint.sh /entrypoint.sh

# run when container starts
ENTRYPOINT ["/entrypoint.sh"]
