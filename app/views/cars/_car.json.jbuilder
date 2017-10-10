json.extract! car, :id, :model, :manufacturer, :status, :lic_no, :hourly_rate, :style, :location, :created_at, :updated_at
json.url car_url(car, format: :json)
