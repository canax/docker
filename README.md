Docker for Anax
====================

Docker images for running, testing and developing Anax and Anax sites.

Images are published on [Docker Store on the Anax organisation](https://hub.docker.com/r/anax/).



Development of images
-------------------

Use docker-compose to try out and test the various images. See `docker-compose.yml` for the collection of images.

```text
docker-compose up php72-apache
```

The script [`update.bash`](update.bash) combines the Docker images from smaller pieces found in the directory [`src/`](src).

Use makefile to build images and then push images and tags.

```text
make build
make push
```

Check what tagets are available.

```text
make
```

Build only a part of the images.

```text
make build-remserver
```

Build and ignore cached values.

```text
make build-remserver options="--no-cache"
```



```
 .
..:  Copyright (c) 2017-2018 Mikael Roos, mos@dbwebb.se
```
