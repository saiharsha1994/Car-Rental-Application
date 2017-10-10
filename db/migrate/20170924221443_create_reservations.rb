class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.integer :car_id
      t.integer :user_id
      t.date :checkout_date
      t.date :return_date
      t.time :checkout_time
      t.time :return_time
      t.time :actual_return_time
      t.decimal :cost

      t.timestamps
    end
  end
end
