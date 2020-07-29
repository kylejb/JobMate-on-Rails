class SavedPostingsController < ApplicationController

    def create 
        @posting = Posting.find(params[:id])
        @saved_posting = SavedPosting.create(user: current_user, posting: @posting)
        redirect_to display_postings_path
    end
    
    # current_user.saved_postings << 

end
