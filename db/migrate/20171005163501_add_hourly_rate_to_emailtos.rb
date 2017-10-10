class AddHourlyRateToEmailtos < ActiveRecord::Migration[5.1]
  def change
    add_column :emailtos, :hourly_rate, :string
  end
end
