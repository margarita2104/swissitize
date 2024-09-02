class RenameBodyToAnswer < ActiveRecord::Migration[7.2]
  def change
    rename_column :cards, :body, :answer
  end
end
