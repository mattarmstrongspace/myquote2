class Author < ApplicationRecord
    has_many :quotes, dependent: :nullify

end
