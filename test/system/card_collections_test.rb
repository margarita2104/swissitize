require "application_system_test_case"

class CardCollectionsTest < ApplicationSystemTestCase
  setup do
    @card_collection = card_collections(:one)
  end

  test "visiting the index" do
    visit card_collections_url
    assert_selector "h1", text: "Card collections"
  end

  test "should create card collection" do
    visit card_collections_url
    click_on "New card collection"

    fill_in "Description", with: @card_collection.description
    fill_in "Name", with: @card_collection.name
    click_on "Create Card collection"

    assert_text "Card collection was successfully created"
    click_on "Back"
  end

  test "should update Card collection" do
    visit card_collection_url(@card_collection)
    click_on "Edit this card collection", match: :first

    fill_in "Description", with: @card_collection.description
    fill_in "Name", with: @card_collection.name
    click_on "Update Card collection"

    assert_text "Card collection was successfully updated"
    click_on "Back"
  end

  test "should destroy Card collection" do
    visit card_collection_url(@card_collection)
    click_on "Destroy this card collection", match: :first

    assert_text "Card collection was successfully destroyed"
  end
end
