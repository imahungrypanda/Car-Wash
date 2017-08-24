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
    # TODO: check if tailgate is down to render a rejection page
  end

  # GET /vehicles/new
  def new
    @vehicle = Vehicle.new
  end

  # POST /vehicles
  # POST /vehicles.json
  def create
    @vehicle = Vehicle.find_or_create_by(license_plate: params[:vehicle][:license_plate])
    p "================================ found ==========================="
    @vehicle.visit unless @vehicle.id.nil?
    p @vehicle

# TODO: add a check for if the license_plate == '1111111' render a go to jail page
    respond_to do |format|
      if @vehicle.update(vehicle_params)
        format.html { redirect_to @vehicle, notice: 'Vehicle was successfully created.' }
        format.json { render :show, status: :created, location: @vehicle }
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
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vehicle_params
      params.require(:vehicle).permit(:vehicle_type, :license_plate, :muddy_bed, :tailgate_down)
    end
end
