class CreateAuthors < ActiveRecord::Migration[8.0]
  def change
    create_table :authors do |t|
      t.string :auth_fname, null: true
      t.string :auth_lname, null: true
      t.integer :birth_year, null:true
      t.integer :death_year, null:true
      t.boolean :is_anon, default: false
      t.text :bio, null: true

      t.timestamps
    end
  end
end
