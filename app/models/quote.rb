class Quote < ApplicationRecord
  belongs_to :user
  belongs_to :author, optional: true

  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  accepts_nested_attributes_for :categorizations, reject_if: :all_blank, allow_destroy: true
end
