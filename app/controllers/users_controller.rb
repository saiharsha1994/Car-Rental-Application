class UsersController < ApplicationController
 @@user=0
  # GET /users
  # GET /users.json
  def index
      @users = User.where(user_type: "user").all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(session[:user_id])
    user=User.find(session[:user_id]).id
    @car=Car.all
    @reservation= Reservation.where("user_id =?",user).where("status =?","Reserved")
    if(@reservation.empty?)
      @reservation= Reservation.where("user_id =?",user).where("status =?","Checkout")
    end
  end

  # GET /users/new
  def new
    @user = User.new
    if logged_in?
      @current_user = User.find(session[:user_id])
    end


  end

  # GET /users/1/edit
  def edit
    if params[:id].empty?
      @user = User.find(session[:user_id])
    else
      @user = User.find(params[:id])
    end

  end

  # POST /users
  # POST /users.json
  def create
    if logged_in?
      @current_user = User.find(session[:user_id])
    end
    @user = User.new(user_params)
    if logged_in?
      if @current_user.user_type=="admin" or @current_user.user_type=="superadmin" and params[:acc_type] == 'admin'

        @user.user_type= "admin"
        if @user.save
          flash[:success] = (" New Admin created successfully: " + @user.name)
          if logged_in?
            redirect_to view_admins_url
          else
            redirect_to root_url
          end
        else
          render 'new'
        end
      end
      if @current_user.user_type=="admin" or @current_user.user_type=="superadmin" and params[:acc_type] == 'user'

        @user.user_type= "user"
        if @user.save
          flash[:success] = (" New User created successfully : " + @user.name)
          if logged_in?
            redirect_to users_url
          else
            redirect_to root_url
          end
        else
          render 'new'
        end
      end
      if @current_user.user_type=="superadmin" and params[:acc_type] == 'superadmin'

        @user.user_type= "superadmin"
        if @user.save
          flash[:success] = ("New Super Admin created successfully: " + @user.name)
          if logged_in? and User.find(session[:user_id]).user_type=="superadmin"
            redirect_to view_superadmins_url
          else
            redirect_to root_url
          end
        else
          render 'new'
        end
      end
      else
        @user.user_type = "user"
        if @user.save
        flash[:success] = ("Registration successful " + @user.name)
        if logged_in? and User.find(session[:user_id]).user_type=="admin"
          redirect_to view_admins_url
        else
          redirect_to root_url
        end
        else
          render 'new'
        end
    end
    end
    def view_admins
      @user = User.find(session[:user_id])
    @users= User.where(user_type:  "admin").all
    end
  def view_superadmins
    @user = User.find(session[:user_id])
    @users= User.where(user_type:  "superadmin").all
  end
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if params[:acc_id].empty?
      render 'edit'
    else
      @user= User.find(params[:acc_id])
      if @user.password_digest.empty?
        puts "hello"
      else @user.update(user_params)
        puts "rerertetretrerterteyeyte #{params[:acc_id]}"
        flash[:success] = "Update successful"
        redirect_to user_url(@user)
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @reservation=Reservation.where("user_id =?",@user.id).where("status =?","Reserved").or(Reservation.where("user_id =?",@user.id).where("status =?","Checkout"))
    if @reservation.empty?
      @user.destroy
      respond_to do |format|
        format.html {redirect_back fallback_location: root_path}
        flash[:success]= 'User was successfully destroyed.'
        format.json { head :no_content }
      end
    else

      respond_to do |format|
        format.html {redirect_back fallback_location: root_path}
        flash[:success]= 'User cannot be deleted as he is reverved with a car'
        format.json { head :no_content }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  def admin_manage_car
    @user = User.find(session[:user_id])
  end
  def user_manage_car
    @user = User.find(session[:user_id])
  end
  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end
end
