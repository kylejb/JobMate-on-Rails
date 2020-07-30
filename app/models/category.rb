class Category < ApplicationRecord
    has_many :users
    validates :title, uniqueness: true
end
