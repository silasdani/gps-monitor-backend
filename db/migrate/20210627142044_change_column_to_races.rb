class ChangeColumnToRaces < ActiveRecord::Migration[6.1]
  def change
    change_column :races, :date, :datetime
  end
end
