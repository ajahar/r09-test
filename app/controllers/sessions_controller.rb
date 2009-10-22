class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]
    user = User.authenticate(email, password)

    if user # If authentication is succesful
      session[:user_id] = user.id
      flash[:notice] = "You've been logged in."
      redirect_to :root
    else # If credentials supplied are wrong
      flash[:error] = "Wrong crendetials, please try again"
      render :action => "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've been logged out."
    redirect_to :root
  end

end
