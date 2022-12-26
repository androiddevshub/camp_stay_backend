class CreateCamps < ActiveRecord::Migration[7.0]
  def change
    create_table :camps do |t|
      t.references :user
      t.string :name
      t.string :camp_type
      t.string :location
      t.text :how_to_get_there
      t.text :nearby_attractions
      t.string :no_of_guests
      t.text   :description
      t.string :contact
      t.string :cost
      t.text :images
      t.timestamps
    end
  end
end
