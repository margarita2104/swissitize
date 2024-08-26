json.extract! card_collection, :id, :name, :description, :created_at, :updated_at
json.url card_collection_url(card_collection, format: :json)
