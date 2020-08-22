require "kafka"

class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def update
    order.update(status: :paid)

    kafka_client.deliver_message(order.as_json.except("id").to_json, topic: "test_orders")

    redirect_to root_path
  end

  private

  def order
    Order.find(params[:id])
  end

  def kafka_client
    @_kafka ||= Kafka.new(
      seed_brokers:             "pkc-ldvj1.ap-southeast-2.aws.confluent.cloud:9092",
      sasl_plain_username:      ENV["CONFLUENT_KEY"],
      sasl_plain_password:      ENV["CONFLUENT_SECRET"],
      ssl_ca_certs_from_system: true
    )
  end
end