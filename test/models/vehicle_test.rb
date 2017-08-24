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

require 'test_helper'

class VehicleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
