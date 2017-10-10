class CreateSuggestions < ActiveRecord::Migration[5.1]
  def change
    create_table :suggestions do |t|
      t.string :model
      t.string :manufacture
      t.string :status
      t.string :lic_no
      t.string :hourly_rate
      t.string :style
      t.string :location

      t.timestamps
    end
  end
end
