json.extract! vehicle, :id, :vehicle_type, :license_plate, :visit_count, :muddy_bed, :tailgate_down, :created_at, :updated_at
json.url vehicle_url(vehicle, format: :json)
