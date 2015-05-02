class AddReceiversToLinks < ActiveRecord::Migration
  def change
    add_column :links, :receivers, :Array
  end
end
