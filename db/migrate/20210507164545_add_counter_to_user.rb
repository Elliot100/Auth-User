class AddCounterToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :counter, :integer, default: 0
  end
end
