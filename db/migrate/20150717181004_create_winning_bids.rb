class CreateWinningBids < ActiveRecord::Migration
  def change
    create_table :winning_bids do |t|
      t.decimal :amount
      t.string :aasm_state
      t.integer :user_id
      t.integer :auction_id
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end
