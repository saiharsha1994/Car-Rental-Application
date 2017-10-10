class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :model
      t.string :manufacturer
      t.string :status
      t.string :lic_no
      t.integer :hourly_rate
      t.string :style
      t.string :location

      t.timestamps
    end
  end
end
