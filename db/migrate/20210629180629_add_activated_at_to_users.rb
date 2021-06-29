class AddActivatedAtToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :activated_at, :datetime
  end
end
