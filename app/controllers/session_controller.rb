class SessionController < ApplicationController
  def create

    user = User.find_by(email: (params[:session][:email]).downcase)

    if user && user.authenticate(params[:session][:password])
      flash[:success] = "Successful Login"
      log_in(user)
      redirect_to user_url(user)
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def new
  end

  def destroy
    log_out
    redirect_to login_url
  end
end
