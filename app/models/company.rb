class Company < ApplicationRecord
    has_many :postings
    has_many :favorite_companies
    has_many :users, through: :favorite_companies
end
