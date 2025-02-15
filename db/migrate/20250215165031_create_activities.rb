class CreateActivities < ActiveRecord::Migration[7.2]
  def change
    create_table :activities do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
