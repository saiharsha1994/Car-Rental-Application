class AddModelToEmailtos < ActiveRecord::Migration[5.1]
  def change
    add_column :emailtos, :model, :string
  end
end
