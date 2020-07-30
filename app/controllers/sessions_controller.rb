class SessionsController < ApplicationController

    def new

        render layout: "sessions/form"
    end
 
    def create
        @user = User.find_by(username: params[:session][:username])

        if @user && @user.authenticate(params[:session][:password])
            session[:current_user_id] = @user.id
            redirect_to user_path(@user)
        else
            redirect_to new_session_path
        end

    end

    def destroy
        # Remove the user id from the session
        session.delete(:current_user_id)
        # Clear the memoized current user
        @_current_user = nil

        redirect_to root_path
    end
end
