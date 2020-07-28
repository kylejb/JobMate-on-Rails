class SessionsController < ApplicationController

    def new
    end
    
    def create
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
            redirect_to user_path(@user)
        else
            redirect_to login_path
        end

    end

    def destroy
        session.destroy

        redirect_to '/'
    end

end