# docker-gophish

> A docker image for the Gophish web application

[![Docker Pulls](https://img.shields.io/docker/pulls/bullshit/gophish.svg)](https://hub.docker.com/r/bullshit/gophish)


## Description

This is a quick way to deploy a [gophish](https://github.com/gophish/gophish) installation on your local machine.

The latest version 0.7.1 is running on the official Debian stretch container. Latest stable image version is 0.7.1.


## Usage

#### Quickstart

```bash
docker run -ti --name gophish -p 3333:3333 -p 8083:80 bullshit/gophish
```
To run as a daemon:

```bash
docker run -d --name gophish -p 3333:3333 -p 8083:80 bullshit/gophish
```

In the examples folder you can find docker-compose files for MySQL and SQLite setup without data persistence.

MySQL:

```bash
docker-compose -f examples/docker-compose-mysql.yml up -d
```

SQLite:

```bash
docker-compose -f examples/docker-compose-sqlite.yml up -d
```

In your browser, go to ```http://your-docker-machine-ip:3333```

#### Configuration

| Environment var | default value | required | gophish json |
| --- | --- | --- | --- |
| CONTACT_ADDRESS | | yes | contact_address |
| ADMIN_SERVER_URL | 0.0.0.0:3000 | no | admin_server.listen_url |
| ADMIN_TLS | false | no | admin_server.use_tls |
| ADMIN_CERT_FILE | | no | admin_server.cert_path |
| ADMIN_KEY_FILE | | no | admin_server.key_path |
| PHISH_SERVER_URL | 0.0.0.0:80 | no | phish_server.listen_url |
| PHISH_TLS | false | no | phish_server.use_tls |
| PHISH_CERT_FILE | | no | phish_server.cert_path |
| PHISH_KEY_FILE | | no | phish_server.key_path |

##### Database
With the environment var DB_DRIVER you can choose your database engine.

| Database | DB_DRIVER | default |
| --- | --- | --- |
| MySQL | mysql | |
| SQLite | sqlite| x |

##### MySQL

| Environment var | default value |
| --- | --- |
| DB_USER | root | 
| DB_PASS | | 
| DB_HOST | db | 
| DB_PORT | 3306 | 
| DB_NAME | gophish | 

##### SQLite
| Environment var | default value |
| --- | --- |
DB_FILE | /opt/gophish/gophish.db |

#### Testing the template file

The expected config files for every testcase are under ./tests/
```bash
$ make test
```

#### Building the image

This command executes every testcase before building the image
```bash
$ make build
```

#### Different gophish version

You can run a different version of gophish by simply applying the corresponding tag.

e.g. `bullshit/gophish:0.1.1`

#### Automated image build

Every commit on the master branch or a tag will be automatically build.


## Contributing

Issues and pull requests are gladly accepted!

## gophish license

Gophish - Open-Source Phishing Framework
The MIT License (MIT)
Copyright (c) 2013 - 2018 Jordan Wright
