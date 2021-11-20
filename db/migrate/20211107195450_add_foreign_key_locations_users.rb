class AddForeignKeyLocationsUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :locations, :users, index: true
  end
end
