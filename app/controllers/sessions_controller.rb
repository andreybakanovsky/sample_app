class SessionsController < ApplicationController
  def new; end

  # def create
  #   user = User.find_by(email: params[:session][:email].downcase)
  #   if user && user.authenticate(params[:session][:password]) # см. описание authenticate ниже
  #     # log in and redirect to the user's show page
  #     log_in(user) # Метод log_in доступен в контроллере Sessions благодаря подключению модуля в листинге 8.11.
  #     params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  #     # redirect_to(user) #or user_url(user),or redirect_to user - комментируем, потому что есть дружественное перенаправление
  #     redirect_back_or(user)
  #   else
  #     # Create an error message
  #     flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
  #     render 'new'
  #   end
  # end

  # authenticate - принимает пароль и, после сравнения хэша расчетного и находящегося в базе данных,
  # возвращиет модель пользователя или false

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message = 'Account not activated. '
        message += 'Check your email for the activation link.'
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
