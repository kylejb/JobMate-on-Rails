class UserCategory < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates_uniqueness_of :user_id, scope: :category_id
  validates_uniqueness_of :category_id, scope: :user_id

end
