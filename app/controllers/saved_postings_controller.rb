class SavedPostingsController < ApplicationController

    def index 
        @postings = current_user.postings
    end

    def create 
        @posting = Posting.find(params[:id])
        @saved_posting = SavedPosting.create(user: current_user, posting: @posting)        
    end
    
end
