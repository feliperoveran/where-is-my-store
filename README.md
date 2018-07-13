[![CircleCI](https://circleci.com/gh/feliperoveran/where-is-my-store.svg?style=shield)](https://circleci.com/gh/feliperoveran/where-is-my-store)

## Setting up the project

### Project dependencies
*  [`docker`](https://docs.docker.com/install/) > 18
*  [`docker-compose`](https://docs.docker.com/compose/install/) > 1.20

Make sure you have installed all dependencies and then run `./scripts/setup`
and let the magic happen.

### Using the helper script
There is a helper script to make our life easier when running commands inside
the container. Run `./scripts/where-is-my-store ` to see the available options.

### Starting the app
Run `./scripts/where-is-my-app start`

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


## Deploying using AWS ECS with Fargate launch type and RDS
#### Creating a database on RDS
This app needs a `postgreSQL` database with `postgis` extensions enabled. See
how to create one DB instance
[here](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_GettingStarted.CreatingConnecting.PostgreSQL.html)
and how to enable the extension
[here](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.PostgreSQL.CommonDBATasks.html#Appendix.PostgreSQL.CommonDBATasks.PostGIS).

#### Using AWS ECS
The easiest way to use containers in ECS is to use Fargate, which handles the
resource allocation for us.
Check
[here](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_GetStarted.html)
to see how to get started using `Fargate`.

Finally, use the sample task definitions on `scripts/task_definitions`,
filling the variable values with the host, username, database name and password
of the created RDS database.

Application logs will be streamed to STDOUT and captured by ECS, so we can check
it on the `logs` tab of the running task

#### Database migrations
Register a task definition using the sample file on
`scripts/task_definitions/where-is-my-store-database-migration.json` and run it
using the correct RDS database variables. Voilà :)
**This should not be registered as a service, but rather used as a one-time only
task**
