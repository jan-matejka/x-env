#!/bin/sh

SELF=${0##*/}

cmd=$SELF-$1
shift

xdgenv-exec XENV x-env -- $cmd "$@"
