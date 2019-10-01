Docker for Anax (dev)
-------------------

Docker images for running, testing and developing Anax and Anax sites.

Anax is a PHP framework. It resides in the [Canax organisation on GitHub](https://github.com/canax).



Supported tags and respective Dockerfile links
-------------------



### PHP CLI

* [`php73-cli`, `php73`, `latest-cli`, `cli`, `latest` (php73/cli/Dockerfile)](https://github.com/canax/docker/blob/master/php73/cli/Dockerfile)
* [`php72-cli`, `php72` (php72/cli/Dockerfile)](https://github.com/canax/docker/blob/master/php72/cli/Dockerfile)
* [`php71-cli`, `php71` (php71/cli/Dockerfile)](https://github.com/canax/docker/blob/master/php71/cli/Dockerfile)
* [`php70-cli`, `php70` (php70/cli/Dockerfile)](https://github.com/canax/docker/blob/master/php70/cli/Dockerfile)
* [`php56-cli`, `php56` (php56/cli/Dockerfile)](https://github.com/canax/docker/blob/master/php56/cli/Dockerfile)



### PHP Apache

* [`php73-apache`, `latest-apache`, `apache` (php73/apache/Dockerfile)](https://github.com/canax/docker/blob/master/php73/apache/Dockerfile)
* [`php72-apache` (php72/apache/Dockerfile)](https://github.com/canax/docker/blob/master/php72/apache/Dockerfile)
* [`php71-apache` (php71/apache/Dockerfile)](https://github.com/canax/docker/blob/master/php71/apache/Dockerfile)
* [`php70-apache` (php70/apache/Dockerfile)](https://github.com/canax/docker/blob/master/php70/apache/Dockerfile)
* [`php56-apache` (php56/apache/Dockerfile)](https://github.com/canax/docker/blob/master/php56/apache/Dockerfile)



### REM server

* [`remserver`, `remserver-apache`, `remserver-php72-apache` (php72/apache/Dockerfile-clone-repo-make-install)](https://github.com/canax/docker/blob/master/php72/apache/Dockerfile-clone-repo-make-install)



Quick reference
-------------------

* Where to get help:
    https://github.com/canax/docker/issues

* Where to file issues:
    https://github.com/canax/docker/issues

* Maintained by:
    [Canax organisation and community](https://github.com/canax/docker/issues)

* Source of this description:
    [doc/anax-dev/README.md](https://github.com/canax/docker/blob/master/doc/anax-dev/README.md)



How to use this image
-------------------

The images are for test and development of Anax and Anax modules.



### General usage and setup

The cli-images uses a user `anax` and the apache-images uses root.

The files are stored in `/home/anax` and you mount the current directory to `/home/anax/repo`.

The apache document root points at `/home/anax/repo`, using the default apache virtual host.



### With docker-compose

Create a `docker-compose.yml` with services for all variants.

```text
version: "3"
services:
    php73:
        image: anax/dev:php73
        volumes: [ ".:/home/anax/repo" ]

    php73-apache:
        image: anax/dev:php73-apache
        ports: [ "10073:80" ]
        volumes: [ ".:/home/anax/repo" ]

    php72:
        image: anax/dev:php72
        volumes: [ ".:/home/anax/repo" ]

    php72-apache:
        image: anax/dev:php72-apache
        ports: [ "10072:80" ]
        volumes: [ ".:/home/anax/repo" ]

    php71:
        image: anax/dev:php71
        volumes: [ ".:/home/anax/repo" ]

    php71-apache: 
        image: anax/dev:php71-apache
        ports: [ "10071:80" ]
        volumes: [ ".:/home/anax/repo" ]

    php70:
        image: anax/dev:php70
        volumes: [ ".:/home/anax/repo" ]

    php70:
        image: anax/dev:php70-apache
        ports: [ "10070:80" ]
        volumes: [ ".:/home/anax/repo" ]

    php56:
        image: anax/dev:php56
        volumes: [ ".:/home/anax/repo" ]

    php56:
        image: anax/dev:php56-apache
        ports: [ "10056:80" ]
        volumes: [ ".:/home/anax/repo" ]

    latest:
        image: anax/dev:latest
        volumes: [ ".:/home/anax/repo" ]

    cli:
        image: anax/dev:cli
        volumes: [ ".:/home/anax/repo" ]

    apache:
        image: anax/dev:apache
        volumes: [ ".:/home/anax/repo" ]
        ports: [ "10099:80" ]

    remserver:
        image: anax/dev:remserver
        ports: [ "10099:80" ]
```

Start an apache container in the background.

```text
docker-compose up -d apache
```

You can then open a browser to localhost:10099.

Run a bash terminal on the running container.

```text
docker-compose exec latest-apache bash
```

Shut down the container.

```text
docker-compose down latest-apache
```



License
-------------------

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.



Acknowledgement
-------------------

This is a co-effort of several people using freely available documentation and tools from the open source community.

For contributors, see commit history and issues.




```
 .
..:  Copyright (c) 2017-2019 Mikael Roos, mos@dbwebb.se
```
