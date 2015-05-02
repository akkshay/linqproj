class AddReceivedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :received, :Array
  end
end
