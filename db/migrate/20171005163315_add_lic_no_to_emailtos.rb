class AddLicNoToEmailtos < ActiveRecord::Migration[5.1]
  def change
    add_column :emailtos, :lic_no, :string
  end
end
