class AddStyleToEmailtos < ActiveRecord::Migration[5.1]
  def change
    add_column :emailtos, :style, :string
  end
end
