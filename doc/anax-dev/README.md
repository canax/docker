Docker for Anax (dev)
-------------------

Docker images for running, testing and developing Anax, Anax modules and Anax sites.

Anax is a PHP framework. It resides in the [Anax organisation on GitHub](https://github.com/canax).

The docker files are either for cli usage or comes with an Apache installation.
 


Supported tags and respective Dockerfile links
-------------------



### PHP CLI

* [`php80-cli`, `php80` (php80/cli/Dockerfile)](https://github.com/canax/docker/blob/master/php80/cli/Dockerfile)
* [`php74-cli`, `php74`, `latest-cli`, `cli`, `latest` (php74/cli/Dockerfile)](https://github.com/canax/docker/blob/master/php74/cli/Dockerfile)
* [`php73-cli`, `php73` (php73/cli/Dockerfile)](https://github.com/canax/docker/blob/master/php73/cli/Dockerfile)
* [`php72-cli`, `php72` (php72/cli/Dockerfile)](https://github.com/canax/docker/blob/master/php72/cli/Dockerfile)
* [`php71-cli`, `php71` (php71/cli/Dockerfile)](https://github.com/canax/docker/blob/master/php71/cli/Dockerfile)
* [`php70-cli`, `php70` (php70/cli/Dockerfile)](https://github.com/canax/docker/blob/master/php70/cli/Dockerfile)
* [`php56-cli`, `php56` (php56/cli/Dockerfile)](https://github.com/canax/docker/blob/master/php56/cli/Dockerfile)



### PHP Apache

* [`php80-apache` (php80/apache/Dockerfile)](https://github.com/canax/docker/blob/master/php80/apache/Dockerfile)
* [`php74-apache`, `latest-apache`, `apache` (php74/apache/Dockerfile)](https://github.com/canax/docker/blob/master/php74/apache/Dockerfile)
* [`php73-apache` (php73/apache/Dockerfile)](https://github.com/canax/docker/blob/master/php73/apache/Dockerfile)
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
    cli:
        image: anax/dev
        volumes: [ ".:/home/anax/repo" ]

    apache:
        image: anax/dev:apache
        volumes: [ ".:/home/anax/repo" ]
        ports: [ "11000:80" ]

    remserver:
        image: anax/dev:apache
        ports:
            - "8090:80"
        volumes: [ ".:/home/anax/repo" ]

    php80:
        image: anax/dev:php80
        volumes: [ ".:/home/anax/repo" ]

    php80-apache:
        image: anax/dev:php80-apache
        ports: [ "11080:80" ]
        volumes: [ ".:/home/anax/repo" ]

    php74:
        image: anax/dev:php74
        volumes: [ ".:/home/anax/repo" ]

    php74-apache:
        image: anax/dev:php74-apache
        ports: [ "11074:80" ]
        volumes: [ ".:/home/anax/repo" ]

    php73:
        image: anax/dev:php73
        volumes: [ ".:/home/anax/repo" ]

    php73-apache:
        image: anax/dev:php73-apache
        ports: [ "11073:80" ]
        volumes: [ ".:/home/anax/repo" ]

    php72:
        image: anax/dev:php72
        volumes: [ ".:/home/anax/repo" ]

    php72-apache:
        image: anax/dev:php72-apache
        ports: [ "11072:80" ]
        volumes: [ ".:/home/anax/repo" ]

    php71:
        image: anax/dev:php71
        volumes: [ ".:/home/anax/repo" ]

    php71-apache:
        image: anax/dev:php71-apache
        ports: [ "11071:80" ]
        volumes: [ ".:/home/anax/repo" ]

    php70:
        image: anax/dev:php70
        volumes: [ ".:/home/anax/repo" ]

    php70:
        image: anax/dev:php70-apache
        ports: [ "11070:80" ]
        volumes: [ ".:/home/anax/repo" ]

    php56:
        image: anax/dev:php56
        volumes: [ ".:/home/anax/repo" ]

    php56:
        image: anax/dev:php56-apache
        ports: [ "11056:80" ]
        volumes: [ ".:/home/anax/repo" ]
```

Start an bash terminal with a container.

```text
docker-compose run cli bash   # latest
docker-compose run php80 bash # specific version
```

Start an apache container in the background.

```text
docker-compose up -d apache       # latest
docker-compose up -d php80-apache # specific version
```

You can then open a browser to localhost:11000.

Run a bash terminal on the running container.

```text
docker-compose exec latest-apache bash
```

Shut down the container and all its volumes.

```text
docker-compose down -v
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
..:  Copyright (c) 2017-2021 Mikael Roos, mos@dbwebb.se
```
