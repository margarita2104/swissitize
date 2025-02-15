class ChangeLanguagesToJsonInUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :languages, :text
    add_column :users, :languages, :text, default: '[]'
  end
end
