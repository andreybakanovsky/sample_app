class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # log in and redirect to the user's show page
      log_in(user) # Метод log_in доступен в контроллере Sessions благодаря подключению модуля в листинге 8.11.      
      redirect_to(user) #or user_url(user),or redirect_to user
    else
      # Create an error message
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
  log_out
  redirect_to root_url
  end
end
