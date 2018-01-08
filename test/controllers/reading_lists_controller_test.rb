require 'test_helper'

class ReadingListsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reading_lists_index_url
    assert_response :success
  end

  test "should get show" do
    get reading_lists_show_url
    assert_response :success
  end

  test "should get new" do
    get reading_lists_new_url
    assert_response :success
  end

  test "should get create" do
    get reading_lists_create_url
    assert_response :success
  end

  test "should get edit" do
    get reading_lists_edit_url
    assert_response :success
  end

  test "should get update" do
    get reading_lists_update_url
    assert_response :success
  end

  test "should get destroy" do
    get reading_lists_destroy_url
    assert_response :success
  end

end
