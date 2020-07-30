class Category < ApplicationRecord
    has_many :user_categories
    has_many :users, through: :user_categories
    validates :title, uniqueness: true

    CATEGORIES = [
    "Front-End Engineer", 
    "Back-End Engineer", 
    "Full-Stack Engineer", 
    "DevOps Engineer", 
    "Site Reliability Engineer", 
    "Cybersecurity Engineer",
    "Data Engineer"]

    def self.update_categories
        CATEGORIES.each do |category|
            Category.create(title: category)
        end
    end

end
