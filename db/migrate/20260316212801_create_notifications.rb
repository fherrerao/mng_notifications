class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :content
      t.string :channel
      t.string :recipient
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
