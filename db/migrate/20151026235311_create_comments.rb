class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :name
      t.string :status
      t.references :user, index: true, foreign_key: true
      t.references :tweet, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
