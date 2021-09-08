ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper # ВНИМАНИЕ: включили для видимости хелпера при его тестировании

  # Add more helper methods to be used by all tests here...


# Returns true if a test user is logged in.
# Так как вспомогательные функции недоступны в тестах, мы не можем использовать current_user
def is_logged_in?
  !session[:user_id].nil?
  end

end
