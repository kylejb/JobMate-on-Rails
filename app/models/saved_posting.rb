class SavedPosting < ApplicationRecord
  belongs_to :user
  belongs_to :posting
  validates_uniqueness_of :user_id, scope: :posting_id
  validates_uniqueness_of :posting_id, scope: :user_id
end
