#!/bin/sh

JEKYLL_BIN=jekyll
HOST=localhost
PORT=4000

# Remove old cache.
rm -rf _site 2>/dev/null

exec $JEKYLL_BIN serve --host $HOST --port $PORT --baseurl '' --drafts --incremental
