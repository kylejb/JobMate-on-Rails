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
        @postings_by_keyword = Posting.search_reduced_query(params[:posting][:keyword])
        @log = Search.add_log(params[:posting][:keyword])
        @postings_by_category = Posting.postings_by_category(current_user)

        @years_experience = YEARS_EXPERIENCE
    end

    def restart_search
        redirect_to search_postings_path
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
