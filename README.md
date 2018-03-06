# SilverStripe

Docker containers for SilverStripe website development.

This container setup should not be used in production.

## Setup

Install docker.

Run `docker-compose up`.

## Usage

Add SilverStripe websites to the `sites` directory.

Websites will be available at `localhost/yourwebsite`.

### Composer commands

The `./composer` command can be used to run composer commands within the container root.

e.g. `./composer install` will install dependencies.

### XDebug

The `docker-compose.yml` is configured for using xdebug on macOS.

You need to change the `remote_enable=0` config to `remote_enable=1` before starting the containers to enable XDebug.

### Database

Database names will automatically be chosen, based on the website folder name in the sites directory.
e.g. `SS_yourwebsite` , if your website foler is `sites/yourwebsite`.

Once the mysql container is running, you can connect to it with your tool of choice at `localhost:4306`