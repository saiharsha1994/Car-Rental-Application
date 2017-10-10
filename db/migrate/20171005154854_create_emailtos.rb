class CreateEmailtos < ActiveRecord::Migration[5.1]
  def change
    create_table :emailtos do |t|
      t.string :user_id
      t.string :email
      t.string :car_id

      t.timestamps
    end
  end
end
