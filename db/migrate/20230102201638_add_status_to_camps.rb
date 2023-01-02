class AddStatusToCamps < ActiveRecord::Migration[7.0]
  def change
    add_column :camps, :license_id, :string
    add_column :camps, :status, :integer, default: 0
  end
end
