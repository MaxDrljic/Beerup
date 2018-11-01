# Beerup

## Project Description

Beerup is a Symfony 4 application powered by API Platform framework. This app is meant to manage beers and the ones added to favorites by the user. Commands can be executed through API Platform UI or by CLI.

## Table Of Contents

-   API Platform
-   CRUD
-   PostgreSQL
-   Doctrine ORM
-   Admin panel
-   Dockerized project
-   JWT authentication
-   Behat tests

## Content To Add / Fix

-   Numeric type of data registered to DB - Fix
-   GraphQL support - To Add

## Installation

1. Clone this repository
2. Go into project
3. Start all services with Docker: \*docker-compose up -d
4. To see the container's logs, run: \*docker-compose logs -f
5. If everything is set properly, check: https://localhost
6. In beerup/api/ you will find all the files related to this Symfony 4 project.

## Usage

This project can be used with API Platform interface, Postman or by using the CLI to manipulate and test the data.

## Development Server

Running \*docker-compose up -d will run the docker containers. If you run it for the first time, it might take a while for Docker to retrieve and download necessary Docker images.

## Changes Made To The Database

In api/src/Entity/ folder, you will find three descriptive entities. In these files, I am defining the schema and Doctrine ORM to map the data to DB. The project is based on PostgreSQL.

If you make any changes to entities in Entity/ folder, be sure to run:

\*docker-compose exec php bin/console doctrine:schema:update --force

To update the schema. Be sure to hit this command while in the api/ folder, not the Root folder.

## Validation

For validation, there is a built-in component in API Platform called [Symfony Validator Component](https://symfony.com/doc/current/validation.html).

## Admin

There is a admin privilege out-of-the-box shipped with API Platform framework where you can manage all the created entities and instances. Admin port is on \*https://localhost:444

## Authentication

\*JWTAuthentcationBundle is included with this project. To set it up:

_$ mkdir config/jwt_

_$ openssl genrsa -out config/jwt/private.pem -aes256 4096_

_$ openssl rsa -pubout -in config/jwt/private.pem -out config/jwt/public.pem_

In case first openssl command forces you to input password use following to get the private key decrypted:

_$ openssl rsa -in config/jwt/private.pem -out config/jwt/private2.pem_

_$ mv config/jwt/private.pem config/jwt/private.pem-back_

_$ mv config/jwt/private2.pem config/jwt/private.pem_

###### Usage

Register a new user:

_$ curl -X POST http://localhost:8000/register -d \_username=johndoe -d \_password=test_

Get a JWT Token:

_$ curl -X POST -H "Content-Type: application/json" http://localhost:8000/login_check -d_

Example of accessing secured routes:

_$ curl -H "Authorization: Bearer [TOKEN]" http://localhost:8000/api_
-> Logged in as johndoe

## Testing

To the test this REST API, Behat is a good choice. To add it:

_$ docker-compose exec php composer require --dev behat/behat_

_$ docker-compose exec php vendor/bin/behat -V_

_$ docker-compose exec php vendor/bin/behat --init_

There is already a small Behat test created to test the basic operations for the beer.

To run it:

_$ docker-compose exec php vendor/bin/behat_

Also, you can run the tests with POSTMAN or using the CLI.
