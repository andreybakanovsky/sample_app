require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @base_title = 'Ruby on Rails Tutorial Coming About'
  end

  test 'layout links' do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
#     Обратите внимание: утверждение для проверки корневого маршрута проверяет
# наличие двух ссылок (одна – для логотипа, и одна – для элемента в меню навигации):

    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path
    assert_select 'a[href=?]', map_path
    get contact_path 
    assert_select 'title', full_title('Contact')
    get signup_path 
    assert_select 'title', full_title('Sign up')

  end
end
