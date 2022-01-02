# Vince's

This is a project written using [Lucky](https://luckyframework.org). Enjoy!

## Setting up the project

1. [Install required dependencies](https://luckyframework.org/guides/getting-started/installing#install-required-dependencies)
1. Update database settings in `config/database.cr`
1. Run `script/setup`
1. Run `lucky dev` to start the app


## Docker

### For dev purposes

Build images

    docker-compose build

Start containers

    docker-compose up

Init the app/database for the first time

    docker-compose exec web ./script/setup

Load posts

    docker-compose exec web lucky load_posts -l fr -d content/fr/

Start dev server

    docker-compose exec web lucky dev

Launch tests

    docker-compose exec web crystal spec

Reset test database (after migradion)

    docker-compose exec --env LUCKY_ENV=test web lucky db.drop

### For production and deploy

Build the images

    docker-compose -f docker-compose-prod.yml build

Tweak `.env.production` values


    LUCKY_ENV=production
    SECRET_KEY_BASE=eQ314uYO30d0OtNnWqAtsuXPZmD70Rc3xTY0AJrjbt4=
    SEND_GRID_KEY=unused
    DATABASE_URL=postgresql://postgres:postgres@db/vinces_production
    HOST=0.0.0.0
    PORT=5001
    APP_DOMAIN=https://vincent.jousse.org

Run the images

    docker-compose -f docker-compose-prod.yml up

Create the production database

    docker-compose exec db createdb -U postgres vinces_production

Run the migrations

    docker-compose exec web crystal run tasks.cr -- db.migrate

Load the posts

    docker-compose exec web crystal run tasks.cr -- load_posts -l fr -d content/fr/

## Deploying the project

1. Make a build release `crystal build --release src/start_server.cr`
1. Load your posts `DATABASE_URL=postgresql://username:password@127.0.0.1/vinces_production crystal run tasks.cr -- load_posts -l fr -d content/fr/`
1. Build the assets `yarn prod`
1. Starts your server with `./start_server`

You should definitively have a look at the [official documentation to deploy the project](https://www.luckyframework.org/guides/deploying/ubuntu).

## Learning Lucky

Lucky uses the [Crystal](https://crystal-lang.org) programming language. You can learn about Lucky from the [Lucky Guides](https://luckyframework.org/guides/getting-started/why-lucky).
