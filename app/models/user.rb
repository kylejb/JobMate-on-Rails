class User < ApplicationRecord
    has_many :favorite_companies
    has_many :companies, through: :favorite_companies
    has_many :saved_postings
    has_many :postings, through: :saved_postings
    has_many :user_categories
    has_many :categories, through: :user_categories
end
