require "application_system_test_case"

class UserCollectionRelationshipsTest < ApplicationSystemTestCase
  setup do
    @user_collection_relationship = user_collection_relationships(:one)
  end

  test "visiting the index" do
    visit user_collection_relationships_url
    assert_selector "h1", text: "User collection relationships"
  end

  test "should create user collection relationship" do
    visit user_collection_relationships_url
    click_on "New user collection relationship"

    click_on "Create User collection relationship"

    assert_text "User collection relationship was successfully created"
    click_on "Back"
  end

  test "should update User collection relationship" do
    visit user_collection_relationship_url(@user_collection_relationship)
    click_on "Edit this user collection relationship", match: :first

    click_on "Update User collection relationship"

    assert_text "User collection relationship was successfully updated"
    click_on "Back"
  end

  test "should destroy User collection relationship" do
    visit user_collection_relationship_url(@user_collection_relationship)
    click_on "Destroy this user collection relationship", match: :first

    assert_text "User collection relationship was successfully destroyed"
  end
end
