[![CircleCI](https://circleci.com/gh/feliperoveran/where-is-my-store.svg?style=shield)](https://circleci.com/gh/feliperoveran/where-is-my-store)

## Setting up the project

### Project dependencies
*  [`docker`](https://docs.docker.com/install/) > 18 (or newer)
*  [`docker-compose`](https://docs.docker.com/compose/install/) > 1.20 (or newer)

Make sure you have installed all dependencies and then run `./scripts/setup`
and let the magic happen.

### Using the helper script
There is a helper script to make our life easier when running commands inside
the container. Run `./scripts/where-is-my-store ` to see the available options.

### Project URL
This project runs on `localhost:3000`. You can change this by editing
`docker-compose.yml` file.

## Testing GraphQL queries and mutations manually
Since this project is API only, we can't render a GraphiQL console like we would
normally do on a Rails app. However, we can use
[graphiql-app](https://github.com/skevy/graphiql-app) that runs a lightweight
Electron based app around GraphiQL.

Download the application image, follow the installation instructions depending on
your OS and voilà.

### Using GraphiQL

#### Running on Linux

After downloading the `AppImage` file, run `sudo chmod +x <app_image_file>` and
then move it to `/usr/local/bin` using `sudo mv <app_image_file> /usr/local/bin`
so you can call it like `graphiql-app` from anywhere :)

#### Running on OSX

Install it using `Brew` using the command `brew cask install graphiql` and then
run it with `graphiql`.
