# docker-fava
LinuxServer-style docker image for [Fava](https://beancount.github.io/fava/index.html). The goal is to have this transferred in to LinuxServer.io.

I've not got a Docker Registry account so there's no live image, you'll have to clone this and build it yourself.

## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=fava \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e BEANCOUNT_FILE=/config/ledger.beancount \
  -p 5000:5000 \
  -v <path to data>:/config \
  --restart unless-stopped \
  linuxserver/fava
```

### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2.1"
services:
  fava:
    image: linuxserver/fava
    container_name: fava
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - BEANCOUNT_FILE=/config/ledger.beancount
    volumes:
      - <path to data>:/config
    ports:
      - 5000:5000
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 5000` | WebUI |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London. |
| `-e BEANCOUNT_FILE=/config/ledger.beancount` | Specify the file or comma-separated list of files for Fava to read. |
| `-v /config` | Contains ledger files. |

## Environment variables from files (Docker secrets)

You can set any environment variable from a file by using a special prepend `FILE__`. 

As an example:

```
-e FILE__PASSWORD=/run/secrets/mysecretpassword
```

Will set the environment variable `PASSWORD` based on the contents of the `/run/secrets/mysecretpassword` file.

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

## Versions

* **2020-05-20:** - Initial release
