class UsersController < ApplicationController
    
    before_action :authorized, only: :show

    def new
        @user = User.new
    end

    def create 
        @user = User.new(user_params)

        if @user.valid?
            @user.save
            session[:current_user_id] = @user.id
            redirect_to user_path(@user)
        else
            redirect_to new_session_path
        end
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
