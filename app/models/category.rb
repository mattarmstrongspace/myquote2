class Category < ApplicationRecord
    has_many :categorizations, dependent: :destroy
    has_many :quotes, through: :categorizations
end
