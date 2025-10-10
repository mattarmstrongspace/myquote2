class Categorization < ApplicationRecord
  belongs_to :quote
  belongs_to :category
  validates :category_id, presence: true
end
