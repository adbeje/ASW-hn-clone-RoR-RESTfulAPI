require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get news" do
    get static_pages_news_url
    assert_response :success
    assert_select "title", "HackersNewsClone"
  end

end
