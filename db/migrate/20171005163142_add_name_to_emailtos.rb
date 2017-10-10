class AddNameToEmailtos < ActiveRecord::Migration[5.1]
  def change
    add_column :emailtos, :name, :string
  end
end
