class SearchesController < ApplicationController

    #this brings up a search form to create a search query
    def new 
        @search = Search.new
    end

    #this runs a number of methods that actaully run the web-scraping methods
    def create 
        @search = Search.new(search_params)
        redirect_to show_search_path
    end

    def show 
        IndeedScraper
        @jobs = IndeedScraper.all
  
    end

    private

    def search_params
        params.require(:search).permit(:keyword, :location)
    end
end