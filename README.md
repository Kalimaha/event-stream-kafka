# Kafka Event Stream

## Setup

### Checkout

> Move to the `checkout` directory

DB must be initialised. Run `docker-compose up` in one tab, then, in a different tab:

```bash
docker-compose run web bundle exec rake db:create db:migrate
```

Then the `checkout` app should be available at http://localhost:3000/.

### Kafka Server

> Move to the `kafka-server` directory

Kafka and Zookeper are orchestrated through Docker Compose:

```bash
docker-compose up
```

## Test

## Run
