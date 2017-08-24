# == Schema Information
#
# Table name: vehicles
#
#  id            :integer          not null, primary key
#  vehicle_type  :string           not null
#  license_plate :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  visit_count   :integer          default("0")
#  tailgate_down :boolean          default("f")
#  muddy_bed     :boolean          default("f")
#

class Vehicle < ApplicationRecord
  validates :vehicle_type, :license_plate, presence: true
  validates :license_plate, length: { is: 7 }
  validate :truck
  validates_exclusion_of :license_plate, :in => ["1111111"]

  def cost
    visit_cost + bed_amount
  end

  def visit
    self.visit_count += 1
    self.save
  end

  def truck?
    self.vehicle_type == 'truck'
  end

  private
  def truck
    if !truck?
      errors.add(:muddy_bed, "isn't part of a car") if self.muddy_bed
      errors.add(:tailgate_down, "is not possible") if self.tailgate_down
    end
  end

  def visit_cost
    amount = truck? ? 10 : 5
    self.visit_count > 0 ? amount / 2 : amount
  end

  def bed_amount
    self.muddy_bed ? 2 : 0
  end
end
