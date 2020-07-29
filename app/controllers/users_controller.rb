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
        @user = current_user
    end

    def update 
        @user = User.find(params[:id])

        if @user.update(user_params)
            redirect_to user_path(@user)
        else
            redirect_to edit_session_path(@user)
        end
    end

    def destroy 
        @user = User.find(params[:id])
        @user.destroy
        session.delete(:current_user_id)
        redirect_to login_path
    end

    private

    def user_params 
        params.require(:user).permit(:username,:password,:password_confirmation)
    end
end
