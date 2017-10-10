class Car < ApplicationRecord

  validates :model, presence: true
  validates :manufacturer, presence: true
  validates :status, presence: true
  validates :lic_no, presence: true, uniqueness: true
  validates :hourly_rate, presence: true
  validates :style, presence: true
  validates :location, presence: true

end

