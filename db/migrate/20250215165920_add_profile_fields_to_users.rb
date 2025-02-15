class AddProfileFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :canton, :string
    add_column :users, :country_of_origin, :string
    add_column :users, :languages, :text
    add_column :users, :avatar, :string
  end
end
