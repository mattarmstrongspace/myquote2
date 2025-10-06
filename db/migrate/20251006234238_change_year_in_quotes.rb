class ChangeYearInQuotes < ActiveRecord::Migration[8.0]
  def change
    change_column :quotes, :year, :integer, null: true
  end
end
