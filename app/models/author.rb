class Author < ApplicationRecord
    has_many :quotes, dependent: :nullify

    #allowing no duplicate full names
    validates :auth_fname, uniqueness: {scope: :auth_lname, case_sensitive: false}, unless: :is_anon
end
