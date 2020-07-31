class PostingsController < ApplicationController

    before_action :set_posting, only: [:show]
    before_action :reset_search, only: [:search, :restart_search]
    #displays all postings tied to a specific user
    def index 
    end

    def show 
        
    end

    #this method will render a form that allows a user to search
    def search
        render 'search'
    end

    #this method will render a form that displays the results of a job search query. 
    #It will receive the params from #search
    def search_results 
        
        #@postings_by_keyword = Posting.postings_by_keyword(params[:posting][:keyword])
        @postings_by_reduced_query = Posting.search_reduced_query(params[:posting][:keyword])
        @log = Search.add_log(params[:posting][:keyword])
        @postings_by_category = Posting.postings_by_category(current_user)

        @years_experience = Posting.years_experience
    end

    def search_by_experience

        @postings_by_reduced_query = Posting.filter_by_experience(params[:years_of_experience])
        @log = Search.add_log(params[:years_of_experience])
        
        @postings_by_category = Posting.postings_by_category(current_user)
        @years_experience = Posting.years_experience

        render 'search_results'
    end

    def restart_search
        redirect_to search_postings_path
    end

    # DEMO FEATURE
    def demo
        demo_apply = IndeedWorker.new
        demo_apply.run(set_posting.link)
        
    end

    private

    def postings_params
        params.require(:posting).permit(:title,:location)
    end

    def set_posting 
        @posting = Posting.find(params[:id])
    end

    def reset_search
        Posting.reset_current_query
        Search.reset_log
    end
end
