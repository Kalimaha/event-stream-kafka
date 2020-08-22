require "kafka"

class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  helper_method :items_description
  def items_description(order)
    order.items.map { |i| "#{i.quantity} #{i.name}" }.join(", ")
  end
end