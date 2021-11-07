class AddForeignKeyLocationsUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :location, :user, index: true
  end
end
