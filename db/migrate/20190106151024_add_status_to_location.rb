class AddStatusToLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :status, :integer, default: 0, null: false
  end
end
