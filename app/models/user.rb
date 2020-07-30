class User < ApplicationRecord
    has_many :favorite_companies
    has_many :companies, through: :favorite_companies
    has_many :saved_postings
    has_many :postings, through: :saved_postings
    belongs_to :category

    has_secure_password

    def category_message
        message = ""
        if self.category != nil
            message = "Your current user category is #{self.category.title}. When you select jobs,
            you will find jobs that other users in this category have chosen. You can change your category below:"
        else
            message = "Choose a category below to be shown postings that othere users in that category have been interested in:"
        end 
        message
    end
end
