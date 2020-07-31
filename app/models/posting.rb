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

  def self.years_experience
    YEARS_EXPERIENCE
  end

  def self.current_query
    @@current_query
  end

  def self.current_query=(query)
    @@current_query = query
  end

  def self.reset_current_query
    @@current_query = Posting.all
  end

  def self.search_reduced_query(keyword)    
    keyword = keyword.downcase
    search_results = []
      current_query.each do |posting|
        if posting.title.downcase.include?(keyword) || posting.description.downcase.include?(keyword) 
          search_results << posting
        end
      end
    self.current_query = search_results
  end

  def self.postings_by_keyword(keyword) #(params[:posting][:keyword])
    keyword = keyword.downcase
    search_results = []
        Posting.all.each do |posting|
            if posting.title.downcase.include?(keyword) ||  posting.description.downcase.include?(keyword) 
                search_results << posting
            end
        end
    search_results
    #I am removing this line so we can use this method specifically for the task of searching through
    #all postings. Posting.search_reduced_query will be the only role that iterates of @@current_query
    #self.current_query = search_results
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
    search_reduced_query(keyword)
  end

  # keyword --> keyword
  # keyword --> years
  # years --> keyword

  def self.filter_by_experience(query_experience)
    arr = current_query.select do |posting| 
       if !(posting.experience == "") && !(posting.experience == nil)
          case query_experience
          when years_experience[0]
            if convert_years_to_integer(posting) <= 2
              posting
            end
          when years_experience[1]
            if convert_years_to_integer(posting) > 2 && convert_years_to_integer(posting) <= 4
              posting
            end
          when years_experience[2]
            if convert_years_to_integer(posting) > 4 && convert_years_to_integer(posting) <= 6
              posting
            end
          when years_experience[3]
            if convert_years_to_integer(posting) > 6 && convert_years_to_integer(posting) <= 10
              posting
            end
          when years_experience[4]
            if convert_years_to_integer(posting) >= 10
              posting
            end
          end
        end
    end
    self.current_query = arr
  end

  #this is for dashboard
  def self.count_postings_by_experience
    years_count = {
      "Less than 2 years of experience: " => 0,
      "Between 2 and 4 years of experience: " => 0,
      "Between 4 and 6 years of experience: " => 0,
      "Between 6 and 10 years of experience: " => 0,
      "More than 10 years of experience: " => 0,
    }

    arr = Posting.all.select do |posting| 
      if !(posting.experience == "") && !(posting.experience == nil)        
            if convert_years_to_integer(posting) <= 2
              years_count["Less than 2 years of experience: "] += 1
            elsif convert_years_to_integer(posting) > 2 && convert_years_to_integer(posting) <= 4
              years_count["Between 2 and 4 years of experience: "] += 1
            elsif convert_years_to_integer(posting) > 4 && convert_years_to_integer(posting) <= 6
              years_count["Between 4 and 6 years of experience: "] += 1
            elsif convert_years_to_integer(posting) > 6 && convert_years_to_integer(posting) <= 10
              years_count["Between 6 and 10 years of experience: "] += 1
            else
              years_count["More than 10 years of experience: "] += 1
            end
      end
    end

    years_count
  end

  def self.convert_years_to_integer(posting_experience) #posting_years
    posting_experience.experience.split.first.to_i
  end

  def self.total_posting_count
    Posting.all.count
  end

  def self.postings_with_no_experience_list
    arr = Posting.all.select do |posting|
      posting.experience == "" || posting.experience == nil
    end
  end

  def self.posting_with_experience_listed_count
    arr = Posting.all.select do |posting|
      !(posting.experience == "") && !(posting.experience == nil)
    end
  end

  def self.entry_level_postings_count(posting_list)
    arr = posting_list.select do |posting|
      #this 'unless'' statement is redundant if you run self.posting_with_experience_listed_count first, 
      #but I put in as an extra failsafe
      Posting.convert_years_to_integer(posting) <= 2 unless posting.experience == "" || posting.experience == nil
    end
  end

  #this method takes an array of categories:string and sorts through postings by categories.
  def self.mass_sort(categories)
    sorted_postings = {}
    #This loop will create a key correspoding to category that points to an array of all postings 
    #that contain that category in description or title
    categories.each do |category|
        #This searches by first word in Category to avoid searching by e.g. 'front-end developer',
        #which would return false for a job posting that included 'front-end engineer'
      category_by_first_word = category.split.first
      sorted_postings[category] = Posting.postings_by_keyword(category_by_first_word)
    end
    sorted_postings
  end

  def self.sorted_postings_by_count(categories)
    sorted_postings = self.mass_sort(categories)

    postings_by_count = {}

    sorted_postings.each do |category,postings|
      postings_by_count[category] = postings.count
    end

    postings_by_count

  end


  # def self.sort_by_job_type
  #   job_categories = [
  #       "Front End Engineer", 
  #       "Back End Engineer", 
  #       "Full Stack Engineer", 
  #       "DevOps Engineer", 
  #       "Site Reliability Engineer", 
  #       "Cybersecurity Engineer",
  #       "Data Engineer"
  #     ]

  #   self.mass_sort(job_categories)
  # end

  # def self.count_by_job_type
  #   job_categories = [
  #       "Front End Engineer", 
  #       "Back End Engineer", 
  #       "Full Stack Engineer", 
  #       "DevOps Engineer", 
  #       "Site Reliability Engineer", 
  #       "Cybersecurity Engineer",
  #       "Data Engineer"
  #     ]

  #     self.count_sorted_postings(job_categories)
  # end

  # def self.sort_by_language
  #   languages = [
  #       "Java", 
  #       "Ruby", 
  #       "PHP", 
  #       "Python", 
  #       "Site Reliability Engineer", 
  #       "Cybersecurity Engineer",
  #       "Data Engineer"
  #     ]

  #   self.mass_sort(languages)
  # end

  # def self.count_by_language
  #   languages = [
  #       "Front End Engineer", 
  #       "Back End Engineer", 
  #       "Full Stack Engineer", 
  #       "DevOps Engineer", 
  #       "Site Reliability Engineer", 
  #       "Cybersecurity Engineer",
  #       "Data Engineer"
  #     ]

  #     self.count_sorted_postings(languages)
  # end


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
