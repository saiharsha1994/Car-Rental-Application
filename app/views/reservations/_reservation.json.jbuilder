json.extract! reservation, :id, :car_id, :user_id, :checkout_date, :return_date, :checkout_time, :return_time, :actual_return_time, :cost, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
