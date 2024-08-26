require "test_helper"

class UserCollectionRelationshipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_collection_relationship = user_collection_relationships(:one)
  end

  test "should get index" do
    get user_collection_relationships_url
    assert_response :success
  end

  test "should get new" do
    get new_user_collection_relationship_url
    assert_response :success
  end

  test "should create user_collection_relationship" do
    assert_difference("UserCollectionRelationship.count") do
      post user_collection_relationships_url, params: { user_collection_relationship: {} }
    end

    assert_redirected_to user_collection_relationship_url(UserCollectionRelationship.last)
  end

  test "should show user_collection_relationship" do
    get user_collection_relationship_url(@user_collection_relationship)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_collection_relationship_url(@user_collection_relationship)
    assert_response :success
  end

  test "should update user_collection_relationship" do
    patch user_collection_relationship_url(@user_collection_relationship), params: { user_collection_relationship: {} }
    assert_redirected_to user_collection_relationship_url(@user_collection_relationship)
  end

  test "should destroy user_collection_relationship" do
    assert_difference("UserCollectionRelationship.count", -1) do
      delete user_collection_relationship_url(@user_collection_relationship)
    end

    assert_redirected_to user_collection_relationships_url
  end
end
