#!/bin/bash
set -e

if (($# != 2)); then
    exit 1
else
    declare -r testrepo1=$1
    declare -r testrepo2=$2
fi

# package test
aursync -n --no-view --repo="$testrepo1" python-nikola # Split package
pacman -Si "$testrepo1"/python-nikola
aursync -n --no-view --repo="$testrepo2" python-nikola # Per-repo versions
pacman -Si "$testrepo2"/python-nikola
aursync -n --no-view --repo="$testrepo1" hnwatch # Split package, pkgbase != pkgname
pacman -Si "$testrepo1"/hnwatch
aursync -n --no-view --repo="$testrepo1" gimp-plugin-separate+ # Special characters
pacman -Si "$testrepo1"/gimp-plugin-separate+
aursync -n --no-view --repo="$testrepo1" ros-build-tools # Empty make/depends
pacman -Si "$testrepo1"/ros-build-tools
aursync -n --no-view --repo="$testrepo2" shaman-git # Special characters - UTF8
pacman -Si "$testrepo2"/shaman-git
aursync -n --no-view --repo="$testrepo2" openrct2-git # make/depends_arch
pacman -Si "$testrepo2"/openrct2-git
#aursync -n --no-view --repo="$testrepo2" aws-cli-git # versioned dependencies
#pacman -Si "$testrepo2"/aws-cli-git
#aursync -n --no-view --repo="$testrepo2" plasma-git-meta # 100+ depends
#aursync -n --no-view --repo="$testrepo1" ros-indigo-desktop-full # 250+ depends

# no-build test
pacman -Slq "$testrepo1" | xargs aursync --no-build --no-view -t
pacman -Slq "$testrepo2" | xargs aursync --no-build --no-view