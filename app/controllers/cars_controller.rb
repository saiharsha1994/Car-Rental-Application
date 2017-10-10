class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.all
    @user = User.find(session[:user_id])

  end

  # GET /cars/1
  # GET /cars/1.json
  def show
    set_car
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
    @car=Car.find(params[:id])
    set_car
  end

  def view_car_history
    puts "ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd #{params[:acc_type]}"
    @carreservation= Reservation.where("car_id =?",params[:acc_type])
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)
    if params[:sgg_no].nil?
    else
       @suggestions=Suggestion.where("id =?",params[:sgg_no])
       @suggestions.delete_all
    end
    respond_to do |format|
      if @car.save
        format.html { redirect_to @car}
        flash[:success]='Car was successfully created.'
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    set_car
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car}
        flash[:success]= 'Car was successfully updated.'
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    set_car
    @reservation=Reservation.where("car_id =?",set_car.id).where("status =?","Reserved").or(Reservation.where("car_id =?",set_car.id).where("status =?","Checkout"))
    if(@reservation.empty?)
      @car.destroy
      respond_to do |format|
        format.html { redirect_to cars_url}
        flash[:success]= 'Car was successfully destroyed!'

        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to cars_url}
        flash[:danger]= 'Car cannot be deleted as it is reserved by someone!'
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:model, :manufacturer, :status, :lic_no, :hourly_rate, :style, :location)
    end
end
