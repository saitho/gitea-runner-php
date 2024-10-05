# Gitea Runner Image with PHP

Enhances the Gitea Runner Image with PHP and Composer, so it does not need to be installed separately.

## Docker Image

```
saitho/gitea-runner-php
```

Find the image on Docker Hub:
https://hub.docker.com/r/saitho/gitea-runner-php

## How to use

Edit `/data/.runner` on the act image and add it to labels section:

```diff+json
{
    "labels": [
        "ubuntu-latest-php:docker://saitho/gitea-runner-php:latest"
    ]
}
```

Now, create workflows with `runs-on: ubuntu-latest-php` and the image should be used.