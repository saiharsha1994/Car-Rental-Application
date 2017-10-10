class AddManufacturerToEmailtos < ActiveRecord::Migration[5.1]
  def change
    add_column :emailtos, :manufacturer, :string
  end
end
