class SavedPosting < ApplicationRecord
  belongs_to :user
  belongs_to :posting
end
