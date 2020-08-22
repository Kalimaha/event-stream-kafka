namespace :kafka do
  task :produce do
    require "kafka"
    require "faker"
    require "securerandom"
    
    kafka_client.deliver_message(order.to_json, topic: "test_orders")
  end
end

def kafka_client
  @_kafka ||= Kafka.new(
    seed_brokers:             "pkc-ldvj1.ap-southeast-2.aws.confluent.cloud:9092",
    sasl_plain_username:      ENV["CONFLUENT_KEY"],
    sasl_plain_password:      ENV["CONFLUENT_SECRET"],
    ssl_ca_certs_from_system: true
  )
end

def order
  line_items = items

  {
    "key": SecureRandom.uuid,
    "status": "in_progress",
    "centsPrice": line_items.map { |li| li[:centsPrice] }.sum,
    "currency": "AUD",
    "lineItems": line_items,
    "createdAt": Time.now.utc,
    "updatedAt": Time.now.utc,
    "customerName": Faker::Name.name,
    "customerAddress": Faker::Address.street_address,
    "customerSuburb": ["Richmond", "South Yarra", "Bundoora"].sample,
    "customerPostcode": ["3121", "3141", "3121"].sample,
    "customerState": ["VIC", "TAS", "NSW"].sample,
    "customerEmail": Faker::Internet.email,
    "customerPhone": Faker::PhoneNumber.phone_number
  }
end

def items
  Array.new(rand(1..5)).map do |i|
    {
      "itemId": SecureRandom.uuid,
      "name": Faker::Food.dish,
      "quantity": rand(1..3),
      "centsPrice": rand(100..3000),
      "currency": "AUD"
    }
  end 
end
