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
        "ubuntu-php83:docker://saitho/gitea-runner-php:php83"
    ]
}
```

Now, create workflows with `runs-on: ubuntu-php83` and the image should be used.

## Images

I provide images for the current PHP 8 versions.
It comes with Composer installed and dependencies required by composer.
The images are updated every Monday automatically via GitHub Actions.

| Image Tag                       | Use Case                              |
|---------------------------------|---------------------------------------|
| `saitho/gitea-runner-php:php83` | Plain PHP 8.3 image with dependencies |
| `saitho/gitea-runner-php:php82` | Plain PHP 8.2 image with dependencies |
| `saitho/gitea-runner-php:php81` | Plain PHP 8.1 image with dependencies |

Some applications require additional packages in order to install or complete builds,
before they can be tested via linters or unit tests. You can find some below.
Please submit a PR in case you need a separate image for your application.

| Image Tag                               | Use Case                              |
|-----------------------------------------|---------------------------------------|
| `saitho/gitea-runner-php:php83-pimcore` | PHP 8.3 image for Pimcore builds      |