require "test_helper"

class CardCollectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @card_collection = card_collections(:one)
  end

  test "should get index" do
    get card_collections_url
    assert_response :success
  end

  test "should get new" do
    get new_card_collection_url
    assert_response :success
  end

  test "should create card_collection" do
    assert_difference("CardCollection.count") do
      post card_collections_url, params: { card_collection: { description: @card_collection.description, name: @card_collection.name } }
    end

    assert_redirected_to card_collection_url(CardCollection.last)
  end

  test "should show card_collection" do
    get card_collection_url(@card_collection)
    assert_response :success
  end

  test "should get edit" do
    get edit_card_collection_url(@card_collection)
    assert_response :success
  end

  test "should update card_collection" do
    patch card_collection_url(@card_collection), params: { card_collection: { description: @card_collection.description, name: @card_collection.name } }
    assert_redirected_to card_collection_url(@card_collection)
  end

  test "should destroy card_collection" do
    assert_difference("CardCollection.count", -1) do
      delete card_collection_url(@card_collection)
    end

    assert_redirected_to card_collections_url
  end
end
