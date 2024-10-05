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

```json
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

## Examples

### Pimcore

`/data/.runner`
```json
{
    "labels": [
        "ubuntu-php83:docker://saitho/gitea-runner-php:php83"
    ]
}
```

Repository: `.gitea/workflows/linter.yml`
```
jobs:
    linter:
        name: Lint
        runs-on: ubuntu-pimcore
        steps:
            - uses: actions/checkout@v2
              with:
                  fetch-depth: 0

            - name: Install dependencies
              run: composer install --ignore-platform-reqs --no-scripts

            # Set server_version via config so Pimcore doesn't try to look it up which results in an error
            - name: Dummy database config for class builds
              run: |
                echo 'doctrine: { dbal: { connections: { default: { server_version: "10.3.39-MariaDB-1:10.3.39+maria~ubu2004-log" } } } }' > config/local/database.yaml

            - name: Build Pimcore classes
              run: bin/console pimcore:build:classes -n

            - name: phpstan
              run: composer run phpstan
```