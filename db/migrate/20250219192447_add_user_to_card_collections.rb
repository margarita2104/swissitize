class AddUserToCardCollections < ActiveRecord::Migration[6.0]
  def change
    add_reference :card_collections, :user, foreign_key: true, null: true

    # Assign a default user to existing records (Modify based on your app)
    default_user = User.first || User.create!(email: 'default@example.com', password: 'password123',
                                              first_name: 'Default', last_name: 'User')
    CardCollection.where(user_id: nil).update_all(user_id: default_user.id)

    # Now enforce NOT NULL
    change_column_null :card_collections, :user_id, false
  end
end
