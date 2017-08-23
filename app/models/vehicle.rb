class Vehicle < ApplicationRecord
  validates :vehicle_type, :license_plate, presence: true
  validates :license_plate, length: { is: 7 }
  validates_exclusion_of :license_plate, :in => ["1111111"]

  def cost
    self.vehicle_type == 'car' ? 5 : 10
  end
end
