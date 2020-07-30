class Posting < ApplicationRecord
  belongs_to :company
  has_many :saved_postings
  has_many :users, through: :saved_postings

  # Posting.where("description like ?", "%#{years}%").count
  
  # persist unique records of job postings
  validates_uniqueness_of :link

  @@current_query = Posting.all

  YEARS_EXPERIENCE = [
    "0 - 2 years",
    "2 - 4 years",
    "4 - 6 years",
    "6 - 10 years",
    "10+ years"
  ]

  def self.current_query
    @@current_query
  end

  def self.reset_current_query
    # @@current_query.clear
    # @@current_query = []

    @@current_query = Posting.all
  end

  def self.search_reduced_query(keyword)    
    keyword = keyword.downcase
    search_results = []
      @@current_query.each do |posting|
        if posting.title.downcase.include?(keyword) ||  posting.description.downcase.include?(keyword) 
          search_results << posting
        end
      end
    current_query = search_results
  end

  def self.postings_by_keyword(keyword) #(params[:posting][:keyword])
    keyword = keyword.downcase
    search_results = []
        Posting.all.each do |posting|
            if posting.title.downcase.include?(keyword) ||  posting.description.downcase.include?(keyword) 
                search_results << posting
            end
        end
    self.current_query = search_results
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

  def self.filter_by_additional_keywords(keyword) #(params[:posting][:keyword])
    self.search_reduced_query(keyword)
  end

  def self.filter_by_experience(experience)
    current_query.each do |posting|

      if posting.experience.chomp == experience_keyword
    end
  end

  def self.filter_by_company

  end

  # def filter_by_title
  # end

  # def filter_by_location
  # end

  # helper method to parse through description column and return experience value
  def extract_experience
    description.match(/[\d ()+]+(?:^|\W)years(?:$|\W)/)
  end
end
