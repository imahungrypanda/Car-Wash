class VehiclesController < ApplicationController
  before_action :set_vehicle, only: [:show, :destroy]

  # GET /vehicles
  # GET /vehicles.json
  def index
    @vehicles = Vehicle.all
  end

  # GET /vehicles/1
  # GET /vehicles/1.json
  def show
  end

  # GET /vehicles/new
  def new
    @vehicle = Vehicle.new
  end

  # POST /vehicles
  # POST /vehicles.json
  def create
    if params[:vehicle][:license_plate] == '1111111'
      respond_to do |format|
        format.html { render :template => 'vehicles/jail' }
        format.json { render json: { message: 'This vehicle has been reported stolen! We will not give service to a stolen vehicle' } }
      end
      return
    end
    # TODO: check if tailgate is down to render a rejection page
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

  # DELETE /vehicles/1
  # DELETE /vehicles/1.json
  def destroy
    @vehicle.destroy
    respond_to do |format|
      format.html { redirect_to vehicles_url, notice: 'Vehicle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    def vehicle_params
      params.require(:vehicle).permit(:vehicle_type, :license_plate, :muddy_bed, :tailgate_down)
    end
end
