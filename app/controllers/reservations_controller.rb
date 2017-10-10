class ReservationsController < ApplicationController
  #before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  @@count=0
  @@count1=0
  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
    user=User.find(session[:user_id]).id
    @showing_reservation=Reservation.where("user_id =?",user)
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to @reservation }
        flash[:success]= 'Reservation was successfully created.'
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  def search_car
    @cars=Car.new
    if @@count==1
      @selectedcars=@@req_cars
    else
    end
    # #debugger
  end

  def search
    @car = Car.new(car_parameters)
    @@req_cars = Car.all
    # #debugger
    puts("#{@car.location}")
    if @car.location!=""
      @@req_cars = @@req_cars.where(location: @car.location).all
    end
    if @car.model!=""
      @@req_cars = @@req_cars.where(model: @car.model).all
    end
    if @car.manufacturer != ""
      @@req_cars = @@req_cars.where(manufacturer: @car.manufacturer).all
    end
    if @car.style != ""
      @@req_cars = @@req_cars.where(style: @car.style).all
    end
    @selectedcars=@@req_cars
    @@count=1
    redirect_to search_car_path
    #redirect_to selected_car_list_path
    #redirect_to :back
    #redirect_to :controller => 'reservations', :action => 'search', :param_a => @selectedcars

  end

  def notify_car
    @carrr=params[:car]
    @cardetails=Car.where("id =?",@carrr)
    email=Emailto.new
    email.user_id=User.find(session[:user_id]).id
    email.name=User.find(session[:user_id]).name
    email.email=User.find(session[:user_id]).email
    email.car_id=@carrr
    @cardetails.each{|x|
      email.model=x.model
      email.manufacturer=x.manufacturer
      email.lic_no=x.lic_no
      email.hourly_rate=x.hourly_rate
      email.style=x.style
    }
    email.save
    redirect_to search_car_path
  end

  def car_parameters
    params.require(:car).permit(:location, :model,:manufacturer, :style)
  end

  def reservation_parameters
    if User.find(session[:user_id]).user_type=="admin"
      params.require(:reservation).permit(:checkout_date, :checkout_time,:return_date, :return_time, :user_id)
    elsif User.find(session[:user_id]).user_type=="superadmin"
      params.require(:reservation).permit(:checkout_date, :checkout_time,:return_date, :return_time, :user_id)
    else
      params.require(:reservation).permit(:checkout_date, :checkout_time,:return_date, :return_time)
    end
  end

  def manage_user_parameters
    params.require(:user).permit(:id)
  end

  def selected_car_list
    @selectedcars=@@req_cars
  end

  def reserve_car
    @reservationcar = Reservation.new
    @carrr=params[:car]
    puts "#{@carrr} hello"
    @carselected=Car.all
    @carselected = @carselected.where(id: params[:car])
    @user = User.find(session[:user_id])
    @user_list=User.where("user_type =?","user")
    @reservation=Reservation.where("user_id =?",User.find(session[:user_id]).id).where("status =?","Reserved")
    if @reservation.empty?
      @reservation=Reservation.where("user_id =?",User.find(session[:user_id]).id).where("status =?","Checkout")
    end
    if @reservation.empty?
    else
      respond_to do |format|
        format.html {redirect_back fallback_location: root_path}
        flash[:danger]='You Have Already Reserved A Car'
        format.json { head :no_content }
      end
    end
    #redirect_to reserve_car_path
    #@carselected = Car.find(params[:car])
  end

  def reserve
    #puts "in reserve"
    #puts "in reserve"
    @reservation = Reservation.new(reservation_parameters)
    @selected_car_id=params[:car_id]
    @useradmin=User.find(session[:user_id]).user_type
    if @useradmin == "admin"
      puts "hii: #{@reservation.user_id} "
      @selected_user_id=@reservation.user_id
      if @selected_user_id.nil?
        respond_to do |format|
          format.html { redirect_to search_car_path, notice: 'Please Select User while selecting timings' }
          format.json { head :no_content }
        end
        else
        @selected_hourly_rate=params[:hourly_rate]
        @reservation.car_id=@selected_car_id
        @reservation.user_id=@selected_user_id
        @reservation.cost=@selected_hourly_rate
        @reservation.status="Reserved"
        @reservation.save
      end
    elsif @useradmin == "superadmin"
      puts "hii: #{@reservation.user_id} "
      @selected_user_id=@reservation.user_id
      if @selected_user_id.nil?
        respond_to do |format|
          format.html { redirect_to search_car_path, notice: 'Please Select User while selecting timings' }
          format.json { head :no_content }
        end
      else
        @selected_hourly_rate=params[:hourly_rate]
        @reservation.car_id=@selected_car_id
        @reservation.user_id=@selected_user_id
        @reservation.cost=@selected_hourly_rate
        @reservation.status="Reserved"
        @reservation.save
      end
    else
      @selected_user_id=User.find(session[:user_id]).id
      @selected_hourly_rate=params[:hourly_rate]
      @reservation.car_id=@selected_car_id
      @reservation.user_id=@selected_user_id
      @reservation.cost=@selected_hourly_rate
      @reservation.status="Reserved"
      @reservation.save
    end
  end

  def reserve_final
    require 'time'
    require 'date'
    @reservation = Reservation.new(reservation_parameters)

    @localcheckoutdate=@reservation.checkout_date
    @localcheckouttime=@reservation.checkout_time
    @localreturntime=@reservation.return_time
    @localreturndate=@reservation.return_date

    @present_time = Time.now
    @c_time= @localcheckouttime.hour + @localcheckouttime.min/60.0;
    @r_time= @localreturntime.hour + @localreturntime.min/60.0;
    @rental_hours= @r_time - @c_time

    @p_time = Time.now.hour+ Time.now.min/60.0

    if @localcheckoutdate -@present_time.to_date >7
      respond_to do |format|
        format.html {redirect_back fallback_location: root_path }
        flash[:danger]= 'Cannot reserve a car more than a week away from now!'
        format.json { head :no_content }
      end
    else
      if @localreturndate < @present_time.to_date or @localcheckoutdate < @present_time.to_date
        respond_to do |format|
          format.html {redirect_back fallback_location: root_path }
          flash[:danger]= 'Choose Future Dates!'
          format.json { head :no_content }
        end

      else
        if @localreturndate - @localcheckoutdate >1
          respond_to do |format|
            format.html {redirect_back fallback_location: root_path }
            flash[:danger]= "Return Day cannot be more than one day apart from Checkout Date!"
            format.json { head :no_content }
          end

        else
          if @localreturndate -@localcheckoutdate ==1
            if @r_time<11
              @r_time = @r_time + 24
            end
          end
          if @localreturndate == @localcheckoutdate and @c_time > @r_time
            respond_to do |format|
              format.html {redirect_back fallback_location: root_path }
              flash[:danger]= "Checkout time cannot be ahead of return time!"
              format.json { head :no_content }
            end

          elsif (@r_time- @c_time >10) or (@r_time - @c_time <1)
            respond_to do |format|
              format.html {redirect_back fallback_location: root_path }
              flash[:danger] = "The minimum rental period is 1 hour and the maximum is 10 hours"
              format.json { head :no_content }
            end
          else
            @somedate = DateTime.new(@localcheckouttime.to_i)
            @selected_car_id=params[:car_id]
            @useradmin=User.find(session[:user_id]).user_type
            if @useradmin == "admin"
              puts "hii: #{@reservation.user_id} "
              @selected_user_id=@reservation.user_id
              if @selected_user_id.nil?
                respond_to do |format|
                  format.html {redirect_back fallback_location: root_path }
                  flash[:danger] = 'Please Select User while selecting timings'
                  format.json { head :no_content }
                end
              else

                @showing_reservation=Reservation.where("user_id =? AND status=?",@reservation.user_id, "Reserved")
                puts "asfklasjfaskljflasjfnlasjflasnf :: #{@showing_reservation.count}"
                if @showing_reservation.count > 0
                  respond_to do |format|
                    format.html { redirect_back fallback_location: root_path}
                    flash[:danger] = 'User already has a car reserved!'
                    format.json { head :no_content }
                  end
                else
                  @selected_hourly_rate=params[:hourly_rate].to_f * (@r_time - @c_time)
                  @reservation.car_id=@selected_car_id
                  @reservation.user_id=@selected_user_id
                  @reservation.cost=@selected_hourly_rate
                  @reservation.status="Reserved"
                  @reservation.save
                end
              end

            elsif @useradmin == "superadmin"
              puts "hii: #{@reservation.user_id} "
              @selected_user_id=@reservation.user_id
              if @selected_user_id.nil?
                respond_to do |format|
                  format.html {redirect_back fallback_location: root_path }
                  flash[:danger] = 'Please Select User while selecting timings'
                  format.json { head :no_content }
                end

              else
                @showing_reservation=Reservation.where("user_id =? AND status=?",@reservation.user_id, "Reserved")

                if @showing_reservation.count > 0
                  respond_to do |format|
                    format.html { redirect_back fallback_location: root_path}
                    flash[:danger] = 'User already has a car reserved!'
                    format.json { head :no_content }
                  end
                else
                  @selected_hourly_rate=params[:hourly_rate].to_f * (@r_time - @c_time)
                  @reservation.car_id=@selected_car_id
                  @reservation.user_id=@selected_user_id
                  @reservation.cost=@selected_hourly_rate
                  @reservation.status="Reserved"
                  @reservation.save
                end
              end
            else
              @selected_user_id=User.find(session[:user_id]).id
              @selected_hourly_rate=params[:hourly_rate].to_f * (@r_time - @c_time)
              @reservation.car_id=@selected_car_id
              @reservation.user_id=@selected_user_id
              @reservation.cost=@selected_hourly_rate
              @reservation.status="Reserved"
              @reservation.save
            end
          end
        end
      end
    end
  end

  def manage_reservation
    @user= User.new
    @user_list=User.where("user_type =?","user")
    if @@count1==1
      @selecteduser=@@req_reservation
    else
    end
  end

  def manage_reservation_list
    @user = User.new(manage_user_parameters)
    puts "hii: #{@user.id} "
    @@req_reservation = Reservation.all
    if @user.id!=""
      @@req_reservation = @@req_reservation.where(user_id: @user.id).all
    end
    @selecteduser=@@req_reservation
    @@count1=1
    redirect_to manage_reservation_path
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation }
        flash[:success]= 'Reservation was successfully updated.'
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  def checkout
    @reservation=Reservation.where("user_id =?",User.find(session[:user_id]).id).where("status =?","Reserved")
    @reservation1=Reservation.new
    @reservation.each{|x|
      @id= x.id
      @reservation1.id=x.id
      @cars_id=x.car_id
      @reservation1.car_id=x.car_id
      @reservation1.user_id=x.user_id
      @reservation1.checkout_date=x.checkout_date
      @reservation1.checkout_time=x.checkout_time
      @reservation1.return_date=x.return_date
      @reservation1.return_time=x.return_time
      @reservation1.actual_return_time=x.actual_return_time
      @reservation1.cost=x.cost
      @reservation1.created_at=x.created_at
      @reservation1.updated_at=x.updated_at
      @reservation1.status="Checkout"
      }
      @reservation.destroy(@id)
      @reservation1.save
      @cars=Car.where("id =?",@cars_id)
      @cars1=Car.new
      @cars.each{|x|
        @idcar= x.id
        @cars1.id=x.id
        @cars1.model=x.model
        @cars1.manufacturer=x.manufacturer
        @cars1.status="Checkout"
        @cars1.lic_no=x.lic_no
        @cars1.hourly_rate=x.hourly_rate
        @cars1.style=x.style
        @cars1.location=x.location
        @cars1.created_at=x.created_at
        @cars1.updated_at=x.updated_at
      }
      @cars.destroy(@idcar)
      @cars1.save
    redirect_to user_path(User.find(session[:user_id]).id)
  end

  def return
    @reservation=Reservation.where("user_id =?",User.find(session[:user_id]).id).where("status =?","Checkout")
    @reservation1=Reservation.new
    @reservation.each{|x|
      @id= x.id
      @reservation1.id=x.id
      @cars_id=x.car_id
      @reservation1.car_id=x.car_id
      @reservation1.user_id=x.user_id
      @reservation1.checkout_date=x.checkout_date
      @reservation1.checkout_time=x.checkout_time
      @reservation1.return_date=x.return_date
      @reservation1.return_time=x.return_time
      @reservation1.actual_return_time=x.actual_return_time
      @reservation1.cost=x.cost
      @reservation1.created_at=x.created_at
      @reservation1.updated_at=x.updated_at
      @reservation1.status="Avaliable"
    }
    @reservation.destroy(@id)
    @reservation1.save
    @cars=Car.where("id =?",@cars_id)
    @cars1=Car.new
    @cars.each{|x|
      @idcar= x.id
      @cars1.id=x.id
      @cars1.model=x.model
      @cars1.manufacturer=x.manufacturer
      @cars1.status="Avaliable"
      @cars1.lic_no=x.lic_no
      @cars1.hourly_rate=x.hourly_rate
      @cars1.style=x.style
      @cars1.location=x.location
      @cars1.created_at=x.created_at
      @cars1.updated_at=x.updated_at
    }
    @cars.destroy(@idcar)
    @cars1.save
    NotifyMailer.new_notify(@cars_id).deliver_now
    @emaildetails=Emailto.where("car_id =?",@cars_id.to_s)
    @emaildetails.delete_all
    redirect_to user_path(User.find(session[:user_id]).id)
  end

  def cancel
    @reservation=Reservation.where("user_id =?",User.find(session[:user_id]).id).where("status =?","Reserved")
    @reservation1=Reservation.new
    @reservation.each{|x|
      @id= x.id
      @reservation1.id=x.id
      @cars_id=x.car_id
      @reservation1.car_id=x.car_id
      @reservation1.user_id=x.user_id
      @reservation1.checkout_date=x.checkout_date
      @reservation1.checkout_time=x.checkout_time
      @reservation1.return_date=x.return_date
      @reservation1.return_time=x.return_time
      @reservation1.actual_return_time=x.actual_return_time
      @reservation1.cost=x.cost
      @reservation1.created_at=x.created_at
      @reservation1.updated_at=x.updated_at
      @reservation1.status="Avaliable"
    }
    @reservation.destroy(@id)
    @reservation1.save
    @cars=Car.where("id =?",@cars_id)
    @cars1=Car.new
    @cars.each{|x|
      @idcar= x.id
      @cars1.id=x.id
      @cars1.model=x.model
      @cars1.manufacturer=x.manufacturer
      @cars1.status="Avaliable"
      @cars1.lic_no=x.lic_no
      @cars1.hourly_rate=x.hourly_rate
      @cars1.style=x.style
      @cars1.location=x.location
      @cars1.created_at=x.created_at
      @cars1.updated_at=x.updated_at
      @cars1.updated_at=x.updated_at
    }
    @cars.destroy(@idcar)
    @cars1.save
    redirect_to user_path(User.find(session[:user_id]).id)
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url}
      flash[:success]= 'Reservation was successfully destroyed.'
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def reservation_params
    params.require(:reservation).permit(:car_id, :user_id, :checkout_date, :return_date, :checkout_time, :return_time, :actual_return_time, :cost)
  end

end
