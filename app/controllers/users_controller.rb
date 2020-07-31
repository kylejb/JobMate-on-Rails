class UsersController < ApplicationController
    before_action :authorized, only: :show

    def new
        @user = User.new
        render layout: "users/form"
    end

    def create 
        @user = User.new(user_params)
        # This is a hard-coded value because foreign_key for category_id is required for validation
        @user.category_id = 3
        if @user.valid?
            @user.save
            session[:current_user_id] = @user.id
            redirect_to user_path(@user)
        else
            # add flash failure
            redirect_to new_user_path
        end
    end

    def show
        current_user
    end

    def edit 
        @user = current_user
    end

    def update 
        if current_user.update(user_params) 
            redirect_to user_path(current_user), success: "Profile was updated successfully"
        else
            redirect_to user_path(current_user), error: current_user.errors.full_messages
        end
    end

    def destroy 
        @user = User.find(params[:id])
        @user.destroy
        session.delete(:current_user_id)
        redirect_to new_session_path
    end

    def choose_category
        @user = current_user
        @message = current_user.category_message
    end

    def assign_category
        current_user.update(user_category_params)
        redirect_to user_path(current_user)
    end

    private

    def user_params 
        params.require(:user).permit(:username,:password,:password_confirmation)
    end

    def user_category_params
        params.require(:user).permit(:category_id)
    end
end
