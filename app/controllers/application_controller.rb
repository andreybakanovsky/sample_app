class ApplicationController < ActionController::Base
    # def hello уже нет необходимости в нем - заменили на home статической страницы
    #     render html: 'Hello)'
    # end
    include SessionsHelper # чтобы метод log_in был доступен, например, не только в контроллере Sessions, но и в Users.

end
