class Search 
    
    attr_accessor :keyword, :location

   def initialize(search_params)
        @keyword = search_params[:keyword]
        @location = search_params[:location]
   end

end