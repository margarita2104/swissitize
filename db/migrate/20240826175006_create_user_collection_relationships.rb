class CreateUserCollectionRelationships < ActiveRecord::Migration[7.2]
  def change
    create_table :user_collection_relationships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :card_collection, null: false, foreign_key: true

      t.timestamps
    end
  end
end
