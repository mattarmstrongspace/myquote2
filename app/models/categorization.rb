class Categorization < ApplicationRecord
  belongs_to :quote
  belongs_to :category

  #ensure that category is mandatory
  validates :category_id, presence: true
end
