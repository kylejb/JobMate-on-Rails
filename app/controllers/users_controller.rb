class UsersController < ApplicationController
    


    def new
        @user = User.new
    end

    def create 
    end

    def show
        current_user
    end

    def edit 
    end

    def update 
    end

    def destroy 
    end
end
