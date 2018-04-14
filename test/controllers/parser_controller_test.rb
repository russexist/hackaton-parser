require 'test_helper'

class ParserControllerTest < ActionDispatch::IntegrationTest
  test "should get site" do
    get parser_site_url
    assert_response :success
  end

end
