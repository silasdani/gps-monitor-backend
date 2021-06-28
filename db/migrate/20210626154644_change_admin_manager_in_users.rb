class ChangeAdminManagerInUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :admin, :boolean, default: false
    change_column :users, :manager, :boolean, default: false
    change_column :users, :activated, :boolean, default: false
  end
end

