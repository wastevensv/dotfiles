#!/bin/env bash
if [ -z "$1" ]; then
    echo Usage: ./stow.sh \<overlay\> [target]
    exit -1
fi
DOTDIR="$(dirname $(realpath -s $0))"
PACKAGE="$1"
TARGET="${2:-$HOME}"

SOURCE="$DOTDIR/$PACKAGE"

pushd $SOURCE &>/dev/null
while read -u 10 dir; do
    echo DIR: $TARGET/$dir/
    mkdir -pv $TARGET/$dir/
done 10< <(find -type d -printf '%P\n')
while read -u 10 file; do
    echo FILE: $TARGET/$file
    ln -siv $(realpath $file) $TARGET/$file
done 10< <(find -type f -printf '%P\n')
popd &>/dev/null
