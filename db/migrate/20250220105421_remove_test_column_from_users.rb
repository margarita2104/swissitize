class RemoveTestColumnFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :test_column, :string
  end
end
