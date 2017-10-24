class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price, :precision => 10, :scale => 2
      t.text :description
      t.string :image_url
      t.belongs_to :categories, index: true, foreign_key: true
    end
  end
end
