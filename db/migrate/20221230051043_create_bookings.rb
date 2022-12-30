class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.integer :camp_owner_id
      t.string :from_date
      t.string :to_date
      t.string :cost
      t.references :camp
      t.timestamps
    end
  end
end
