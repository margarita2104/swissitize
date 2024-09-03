class CreateCards < ActiveRecord::Migration[7.2]
  def change
    create_table :cards do |t|
      t.string :question
      t.string :body
      t.references :card_collection, null: false, foreign_key: true

      t.timestamps
    end
  end
end
