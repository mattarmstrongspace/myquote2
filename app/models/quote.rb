class Quote < ApplicationRecord
  belongs_to :user
  belongs_to :author, optional: true

  #quote can have many categories through categorizations tables
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations

  #allow nested author fields to be submitted with quote form
  accepts_nested_attributes_for :author

  #ensure that both category and quote fields are present before saving
  validates :categories, presence: true
  validates :quote, presence: true
end
