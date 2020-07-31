class StaticPagesController < ApplicationController

    before_action :authorized, only: :dashboard
    
    def dashboard
        
        @job_categories = DashboardVars.job_categories

        @languages = DashboardVars.languages

        @total_posting_count = Posting.total_posting_count
        
        @postings_experience_count = Posting.count_postings_by_experience

        @postings_no_experience_listed_count = Posting.postings_with_no_experience_list.count

        @postings_job_category_count = Posting.sorted_postings_by_count(@job_categories)

        @postings_languages_count = Posting.sorted_postings_by_count(@languages)

    end

    def demo
        apply_demo = IndeedWorker.new
        apply_demo.run
    end

end