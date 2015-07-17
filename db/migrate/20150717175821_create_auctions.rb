class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :title
      t.text :details
      t.datetime :end_date
      t.integer :reserve_price
      t.integer :current_price
      t.datetime :created_at
      t.datetime :updated_at
      t.string :aasm_state
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
