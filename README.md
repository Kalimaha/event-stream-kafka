# Kafka Event Stream

This demo project leverages Kafka to orchestrate two small web-apps, `checkout` and `kitchen`, to simulate a take-away system. An "order" is randomly generated and published to the `test_orders` topic with the `in_progress` status _(as in, the customer is deciding what to eat tonight)_. The topic is then consumed by the two apps that will update the status of the "orders". Available statuses are:

* `in_progress` _(checkout)_
* `paid` _(checkout)_
* `cooking` _(kitchen)_
* `dispatched` _(kitchen)_
* `delivered` _(checkout)_

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

### Kitchen

> Move to the `kitchen` directory

DB must be initialised. Run `docker-compose up` in one tab, then, in a different tab:

```bash
docker-compose run web bundle exec rake db:create db:migrate
```

Then the `kitchen` app should be available at http://localhost:4000/. While the app is running, in a separate tab, run:

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

### Generate and publish random orders to Kafka

> Move to `kafka-utils` directory

```bash
bundle exec rake kafka:produce
```

## Test

No tests. Zero. Nada.
