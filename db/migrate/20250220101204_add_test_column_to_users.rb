class AddTestColumnToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :test_column, :string
  end
end
