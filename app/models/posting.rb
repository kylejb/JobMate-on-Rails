class Posting < ApplicationRecord
  belongs_to :company
  has_many :saved_postings
  has_many :users, through: :saved_postings

  # Posting.where("description like ?", "%#{years}%").count
  # Posting.all.first.description.match(/[0-9](?:^|\W)years(?:$|\W)/)

  # persist unique records of job postings
  validates_uniqueness_of :link

  # helper method to parse through description column and return experience value
  def extract_experience
    description.match(/[\d ()+]+(?:^|\W)years(?:$|\W)/)
  end
end
