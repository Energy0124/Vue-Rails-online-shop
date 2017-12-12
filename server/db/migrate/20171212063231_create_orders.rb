class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :payment_id
      t.string :currency
      t.text :items
      t.belongs_to :user
      t.decimal :total_price, :precision => 10, :scale => 2
      t.string :salt
      t.string :digest
      t.string :merchant
      t.string :status
      t.string :buyer
      t.timestamps
    end
  end
end
