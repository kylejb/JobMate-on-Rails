class PostingsController < ApplicationController

    before_action :set_posting, only: [:show]

    #displays all postings tied to a specific user
    def index 
    end

    def show 
        
    end

    def destroy  
    end

    #this method will render a form that allows a user to search
    def search
        render 'search'
    end

    #this method will render a form that displays the results of a job search query. 
    #It will receive the params from #search
    def search_results 
        @search_results = Posting.postings_by_keyword(params[:posting][:title])

        @postings_by_category = Posting.postings_by_category(current_user)
    end

    private

    def postings_params
        params.require(:posting).permit(:title,:location)
    end

    def set_posting 
        @posting = Posting.find(params[:id])
    end
    
end
