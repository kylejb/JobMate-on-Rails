class SessionsController < ApplicationController

    def new
    end

    def create
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
            redirect_to user_path(@user)
        else
            redirect_to new_session_path
        end

    end

    def destroy
        session.delete(:current_user_id)

        redirect_to '/'
    end

end