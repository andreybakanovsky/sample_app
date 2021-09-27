class ApplicationController < ActionController::Base
    # def hello уже нет необходимости в нем - заменили на home статической страницы
    #     render html: 'Hello)'
    # end
    include SessionsHelper # чтобы метод log_in был доступен, например, не только в контроллере Sessions, но и в Users.

    private
    
  # Confirms a logged-in user  
  # Подтверждает вход пользователя
  def logged_in_user
    unless logged_in?
      store_location # запоминаем URL по которому хотел перейти пользователь
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end
end
