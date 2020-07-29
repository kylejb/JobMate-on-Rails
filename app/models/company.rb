class Company < ApplicationRecord
    has_many :postings
    has_many :favorite_companies
    has_many :users, through: :favorite_companies

    # persist unique records of companies with job posting(s)
    validates_uniqueness_of :name
end
