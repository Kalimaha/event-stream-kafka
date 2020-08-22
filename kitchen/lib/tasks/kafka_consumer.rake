namespace :kafka do
  desc "Consume Kafka Topics"
  task :consume => :environment do
    require "kafka"

    kafka = Kafka.new(
      seed_brokers: "pkc-ldvj1.ap-southeast-2.aws.confluent.cloud:9092",
      sasl_plain_username: ENV["CONFLUENT_KEY"],
      sasl_plain_password: ENV["CONFLUENT_SECRET"],
      ssl_ca_certs_from_system: true
    )
    consumer = kafka.consumer(group_id: "vinomofo_test_consumers")
    consumer.subscribe("test_orders")

    trap("TERM") { consumer.stop }

    kafka.each_message(topic: "test_orders") do |message|
      data = JSON.parse(message.value)

      puts "==="
      puts data
      puts "---"
      puts data.dig("lineItems")
      puts "==="

      puts "Process (or not) order #{data.dig("key")}"
      order = Order.find_or_initialize_by(key: data.dig("key"))
      if order.id.nil? && data.dig("status") == "paid"
        order = Order.create(
          key: data.dig("key"),
          status: data.dig("status"),
          customer_name: data.dig("customerName"),
          customer_address: data.dig("customerAddress"),
          customer_suburb: data.dig("customerSuburb"),
          customer_postcode: data.dig("customerPostcode"),
          customer_state: data.dig("customerState"),
          customer_email: data.dig("customerEmail"),
          customer_phone: data.dig("customerPhone"),
          created_at: data.dig("createdAt"),
          updated_at: data.dig("updatedAt")
        )

        data.dig("lineItems")&.each do |item|
          Item.create(
            key: item.dig("itemId"),
            name: item.dig("name"),
            quantity: item.dig("quantity"),
            order: order
          )
        end
      end
    end
  end
end