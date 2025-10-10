class Quote < ApplicationRecord
  belongs_to :user
  belongs_to :author, optional: true

  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations

  accepts_nested_attributes_for :author

  validates :categories, presence: true
  validates :quote, presence: true
end
