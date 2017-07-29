#! /bin/sh

SELF=${0##*/}

cg=$XENV_CONFIG_HOME/anchor

die() {
  printf >&2 -- "%s: %s %s\n" $SELF "$@"
  exit 1
}

anchor=$(cat $cg)
test -n "$anchor" || die "failed to read %s" $cg

pid=$(pgrep -u $(whoami) -f $anchor) || die "pgrep failed: %s" $anchor

len=$(echo "$pid" | wc -l)

[ $len -eq 1 ] || die "pgrep matched >1 processes: %s" $anchor

environ=/proc/$pid/environ
cat $environ | xargs -0 -n1 echo export
