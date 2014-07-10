class LoginController < ApplicationController
  skip_before_action :authenticate_user

  def new
    puts session[:redirect_to]
  end

  def create
    login = params[:login]
    user = User.find_by(email: login[:email])

    if user and user.authenticate login[:password]
      session[:user_id] = user.id
      redirect = session[:redirect_to]
      session[:redirect_to] = nil

      redirect_to (redirect || root_url), notice: "Successful"
    else
      redirect_to root_url, notice: "Un-successful"
    end

  end


  def destroy
    session[:user_id] = nil
    @current_user = nil
    redirect_to root_url, notice: "Logged out"
  end

end
