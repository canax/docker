Docker for Anax (dev)
-------------------

Docker images for running, testing and developing Anax and Anax sites.

Anax is a PHP framework. It resides in the [Canax organisation on GitHub](https://github.com/canax).



Supported tags and respective Dockerfile links
-------------------

* [`php71-apache`, `php71`, `latest` (php71/apache/Dockerfile)](https://github.com/canax/docker/blob/master/php71/apache/Dockerfile)
* [`php70-apache`, `php70` (php70/apache/Dockerfile)](https://github.com/canax/docker/blob/master/php70/apache/Dockerfile)
* [`php56-apache`, `php56` (php56/apache/Dockerfile)](https://github.com/canax/docker/blob/master/php56/apache/Dockerfile)



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



### With docker-compose

Create a `docker-compose.yml` with a service "website" using this image.

```text
version: "3"
services:
    website:
        image: anax/dev
        ports:
            - "8080:80"
        volumes:
            - .:/app
            - ./config/dbwebb.se.conf:/etc/apache2/sites-enabled/000-default.conf
```

Use a volume to mount your project directory into the image.

Use a volume to provide a apache virtual host as a base for the default host in the webserver.

The virtual host can/should point out the document root to use. Usually this is `./htdocs` for Anax, or `/app/htdocs` within the container.

Create a directory `log` where apache will write its logs.

Start the container in the background.

```text
docker-compose up -d website
```

Open a browser to localhost:8080.

Run a bash terminal on the container.

```text
docker-compose exec website bash
```

Shut down the container.

```text
docker-compose down website
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
..:  Copyright (c) 2017 dbwebb et al, anax@dbwebb.se
```
