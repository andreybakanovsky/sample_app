require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = 'Ruby on Rails Tutorial Coming About'
  end
  
  test "should get home" do
    # get static_pages_home_url - уже нет такого пути, см. routs
    get root_url
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get help" do
    get help_url
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "should get about" do
    get about_url
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get contact" do
    get contact_url
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end

  test "should get map" do
    get map_url
    assert_response :success
    assert_select "title", "Map | #{@base_title}"
  end

end
