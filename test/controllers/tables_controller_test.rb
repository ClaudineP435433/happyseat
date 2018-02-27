require 'test_helper'

class TablesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tables_index_url
    assert_response :success
  end

  test "should get update" do
    get tables_update_url
    assert_response :success
  end

end
