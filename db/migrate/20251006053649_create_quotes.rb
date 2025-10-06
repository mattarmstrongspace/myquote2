class CreateQuotes < ActiveRecord::Migration[8.0]
  def change
    create_table :quotes do |t|
      t.text :quote, null: false
      t.integer :year, null: false
      t.boolean :is_public, default: true
      t.text :comment, null: true
      t.references :user, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
