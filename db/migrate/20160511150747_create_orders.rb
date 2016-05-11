class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.text :address
      t.string :pay_type
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
