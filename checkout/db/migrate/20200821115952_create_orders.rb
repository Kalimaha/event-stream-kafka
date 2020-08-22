class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :key
      t.string :status
      t.string :currency
      t.integer :cents_price
      t.string :customer_name
      t.string :customer_address
      t.string :customer_suburb
      t.string :customer_postcode
      t.string :customer_state
      t.string :customer_email
      t.string :customer_phone

      t.timestamps
    end

    create_table :items do |t|
      t.references :order
      t.string :key
      t.string :name
      t.string :currency
      t.integer :quantity
      t.integer :cents_price

      t.timestamps
    end
  end
end
