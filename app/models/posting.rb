class Posting < ApplicationRecord
  belongs_to :company
  has_many :saved_postings
  has_many :users, through: :saved_postings

  # persist unique records of job postings
  validates_uniqueness_of :url
end
