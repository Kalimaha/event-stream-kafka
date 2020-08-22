# Kafka Event Stream

## Setup

### Checkout

> Move to the `checkout` directory

DB must be initialised. Run `docker-compose up` in one tab, then, in a different tab:

```bash
docker-compose run web bundle exec rake db:create db:migrate
```

Then the `checkout` app should be available at http://localhost:3000/. While the app is running, in a separate tab, run:

```bash
docker-compose run web bundle exec rake kafka:consume
```

This will start the Kafka consumer that listens to the `test_orders` topic and stores new records in the DB.

### Kafka

Kafka is setup in Confluent with:

* Cluster: `vinomofo_test`
* Topic: `test_orders`

For the app to work, you have to setup the following variables:

* `CONFLUENT_KEY`
* `CONFLUENT_SECRET`

#### Publish random orders to Kafka

> Move to `kafka-utils` directory

```bash
bundle exec rake kafka:produce
```

## Test

## Run
