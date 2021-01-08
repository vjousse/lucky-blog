# Vince's

This is a project written using [Lucky](https://luckyframework.org). Enjoy!

### Setting up the project

1. [Install required dependencies](https://luckyframework.org/guides/getting-started/installing#install-required-dependencies)
1. Update database settings in `config/database.cr`
1. Run `script/setup`
1. Run `lucky dev` to start the app

### Deploying the project

1. Make a build release `crystal build --release src/start_server.cr`
1. Load your posts `DATABASE_URL=postgresql://username:password@127.0.0.1/vinces_production crystal run tasks.cr -- load_posts -l fr -d content/fr/`
1. Build the assets `yarn prod`
1. Starts your server with `./start_server`

You should definitively have a look at the [official documentation to deploy the project](https://www.luckyframework.org/guides/deploying/ubuntu).

### Learning Lucky

Lucky uses the [Crystal](https://crystal-lang.org) programming language. You can learn about Lucky from the [Lucky Guides](https://luckyframework.org/guides/getting-started/why-lucky).
