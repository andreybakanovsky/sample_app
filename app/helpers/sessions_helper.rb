module SessionsHelper
  # Logs in the given user.
  def log_in(user)
    # Эта инструкция передаст браузеру пользователя cookie с зашифрованной вер-
    # сией идентификатора пользователя, что позволит получить его на следующей
    # странице через session[:user_id]
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any - если есть).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
