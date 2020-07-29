class HomeController < ApplicationController

    before_action :authorized, only: :dashboard
    
    def dashboard
        
    end

end