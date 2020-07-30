class Posting < ApplicationRecord
  belongs_to :company
  has_many :saved_postings
  has_many :users, through: :saved_postings

  #attr_reader :url

  # persist unique records of job postings
  validates_uniqueness_of :link

  def self.postings_by_keyword(keyword)
    search_results = []

        Posting.all.each do |posting|
            if posting.title.include?(keyword) # && posting.location.include?(params[:location])
                search_results << posting
            end
        end

    search_results
  end

  def self.postings_by_category(current_user)

    postings_by_category = []

    User.all.each do |user|
      if current_user.category != nil && user.category == current_user.category
        postings_by_category << user.postings
      end
    end

    postings_by_category
  end
end
