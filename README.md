# Car Wash

Car Wash is a Ruby on Rails application that tracks what cars have come through the car wash and calculates their amount that the wash costs. The car wash adepts both cars and trucks. For cars the wash only cost $5. For trucks the was costs $10. There is an extra charge of $2 if there is mud in the bed, and if the tailgate is down they are refused service. Vehicles with the license plate '1111111' are stolen and will not be given service.

### Setup

1. Download this repo
2. Run `bundle install` to install the necessary gems
3. Run `rails db:setup` to create the database
4. Run `rails start` to start the server
5. Navigate to `http://localhost:3000/`


### Implementation

The create method contains the most of the main logic for the program. First it checks if the `license_plate` was marked stolen. After it finds the vehicle or creates a new vehicle. Lastly it renders a special view if the tailgate was down.

```Ruby
def create
  if params[:vehicle][:license_plate] == '1111111'
    respond_to do |format|
      format.html { render :template => 'vehicles/jail' }
      format.json { render json: { message: 'This vehicle has been reported stolen! We will not give service to a stolen vehicle' } }
    end
    return
  end

  @vehicle = Vehicle.find_or_create_by(license_plate: params[:vehicle][:license_plate])
  @vehicle.visit unless @vehicle.id.nil?

  respond_to do |format|
    if @vehicle.update(vehicle_params)
      if @vehicle.tailgate_down
        format.html { render :template => 'vehicles/no_service' }
        format.json { render json: { message: 'This vehicle has the tailgate down' } }
      else
        format.html { redirect_to @vehicle, notice: 'Vehicle was successfully created.' }
        format.json { render :show, status: :created, location: @vehicle }
      end
    else
      format.html { render :new }
      format.json { render json: @vehicle.errors, status: :unprocessable_entity }
    end
  end
end
```

### API Endpoints

| Route     | Description     |
| :------------- | :------------- |
| GET `/vehicles`       | Shows the index of all the veichles that have visited       |
| POST `/vehicles`      | Creates a new vehicle or finds a returning vehicle and shows the amount the car wash will be       |
| GET `/vehicles/new`   | Gets the form for a visit       |
| GET `/vehicles/:id`   | Gets the information that was stored about the last visit the vehicle made       |
| DELETE `/vehicles/:id`| Deletes the vehicle from the database       |

*NOTE: All endpoints respond to both `.html` and `.json`*

### Database

| Column Name     | Data type      | Description |
| :-------------  | :------------- | :------------- |
| vehicle_type    | String         | Stores the type of vehicle (car or truck) |
| license_plate   | String         | Store the license plate number to be able to know if a vehicle has visited before |
| visit_count     | Integer        | Counts the number of times a vehicle has visited |
| tailgate_down   | Boolean        | Keeps track if the tailgate was down the last time the vehicle visited |
| muddy_bed       | Boolean        | Keeps track if the bed was muddy the last time the vehicle visited |
