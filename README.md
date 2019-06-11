# ![](https://github.com/docker-suite/artwork/raw/master/logo/png/logo_32.png) gh-latest
![License: MIT](https://img.shields.io/github/license/docker-suite/goss.svg?color=green&style=flat-square)

Simple utility to get the **latest release version** from GitHub repository

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Usage

```sh
Usage: gh-latest.sh [user repo] [OPTIONS]

    -u | --user         Github user olding the repository
    -r | --repo         Github repository
    -T | --token        Github token

Alternatively, you can specify the user and the repo in the right order.

Examples:
    gh-latest.sh -u bash-suite -r wait-host      Get the latest release version of wait-host
    gh-latest.sh bash-suite wait-host            Get the latest release version of wait-host
```

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) GitHub token

If you don't want to face a [Github rate limit](https://developer.github.com/v3/rate_limit/) use a personnal token:

```sh
export MYTOKEN="13546843257517438573"

./gh-downloader.sh -t $MYTOKEN -u bash-suite -r wait-host -t latest -f wait-host.sh -o /usr/sbin/wait-host
```

Get a GitHub personal token from here:  [github.com/settings/tokens](github.com/settings/tokens)
