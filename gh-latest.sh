#!/bin/sh
#
# `gh-latest.sh` is as imple utility to get the **latest release version** from GitHub repository
#

# set -e : Exit the script if any statement returns a non-true return value.
set -e

# Default values
readonly progname=$(basename $0)

# Display help message
getHelp() {
    cat << USAGE >&2

Usage: $progname [user repo] [OPTIONS]

    -u | --user         Github user olding the repository
    -r | --repo         Github repository
    -T | --token        Github token

Alternatively, you can specify the user and the repo in the right order.

Examples:
    $progname -u bash-suite -r wait-host      Get the latest release version of wait-host
    $progname bash-suite wait-host            Get the latest release version of wait-host

USAGE
}


# Get input parameters
while [ $# -gt 0 ]; do
    case "$1" in
        
        [!-]* )
            [ -n "$USER" -a -z "$REPO" ] && REPO=$1
            [ -z "$USER" ] && USER=$1
            shift 1
        ;;

        -u|--user)
            USER="$2"
            [ -z "$USER" ] && break
            shift 2
        ;;

        -u=*|--user=*)
            USER=$(printf "%s" "$1" | cut -d = -f 2)
            [ -z "$USER" ] && break
            shift 1
        ;;

        -r|--repo)
            REPO="$2"
            [ -z "$REPO" ] && break
            shift 2
        ;;

        -r=*|--repo=*)
            REPO=$(printf "%s" "$1" | cut -d = -f 2)
            [ -z "$REPO" ] && break
            shift 1
        ;;

        -T|--token)
            TOKEN="$2"
            shift 2
        ;;

        -T=*|--token=*)
            TOKEN=$(printf "%s" "$1" | cut -d = -f 2)
            shift 1
        ;;

        --help)
            getHelp
            exit 0
        ;;

        *)
            echo "Invalid argument '$1'. Use --help to see the valid options"
            exit 1
        ;;

    esac
done

# check for user and repo
if [ -z "$USER" -o -z "$REPO" ]; then
    echo "Invalid user or repo. Use --help to see the valid options."
    exit 2
fi

# Check installed softwares
CURL=$(command -v curl >/dev/null 2>&1; echo $?)
JQ=$(command -v jq >/dev/null 2>&1; echo $?)

# curl must be installed: https://curl.haxx.se/
if [ $CURL -ne 0 ]; then
    echo "In order to use '$progname' curl must be installed" 1>&2
    exit 1
fi

# js must be installed: https://stedolan.github.io/jq/
if [ $JQ -ne 0 ]; then
    echo "In order to use '$progname' jq must be installed" >&2
    exit 1
fi

# Github API
API='https://api.github.com'

# Get the latest version
VERSION=$(curl ${TOKEN:+ -H "Authorization: token $TOKEN"} ${HTTP_PROXY:+ -x $HTTP_PROXY} -s $API/repos/$USER/$REPO/releases/latest | jq -r ".tag_name")

# Return version
[ $VERSION = 'null' ] && echo '' || echo $VERSION
