module SessionsHelper
  # Logs in the given user.
  def log_in(user)
    # Эта инструкция передаст браузеру пользователя cookie с зашифрованной вер-
    # сией идентификатора пользователя, что позволит получить его на следующей
    # странице через session[:user_id]
    session[:user_id] = user.id
  end

  # Запоминает пользователя в постоянном сеансе.
  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id # сохраняем в куки зашифрованный идентификатор пользователя
    cookies.permanent[:remember_token] = user.remember_token # сохранияем в куки токен
  end

  # Returns the current logged-in user (if any - если есть).
  # def current_user
  #   @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  # end

  # Returns the user corresponding to the remember token cookie.
  def current_user
    # varian 1
    # if session[:user_id] # если пользователь вошел
    #   @current_user ||= User.find_by(id: session[:user_id]) # определяем текущего пользователя
    # elsif cookies.encrypted[:user_id] # если не вошел - расшифровываем идентификатор пользователя который в куках
    #   user = User.find_by(id: cookies.encrypted[:user_id]) # находим пользователя по его идентификатору в базе данных
    #   if user && user.authenticated?(cookies[:remember_token]) # если найден и его токен в куках соответствует токену в базе данных
    #     log_in user # выполняем вход
    #     @current_user = user # определяем текущего юзера как юзера с которым мы работали
    #   end
    # end

    # variant 2
    # исключаем повторение вызовов session и cookies
    if (user_id = session[:user_id]) # Если в сеансе существует id пользователя (при этом присвоим его переменной user_id) ...»
      @current_user ||= User.find_by(id: user_id) # определяем текущего пользователя
    elsif (user_id = cookies.encrypted[:user_id]) # Если существует расшифрованное id пользователя в куках (при этом присвоим его переменной user_id)
      user = User.find_by(id: user_id) # находим пользователя по его идентификатору в базе данных
      if user && user.authenticated?(cookies[:remember_token]) # если найден и его токен в куках соответствует токену в базе данных
        log_in user # выполняем вход
        @current_user = user # определяем текущего юзера как юзера с которым мы работали
      end
    end
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    # user && user == current_user
    user == current_user
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
