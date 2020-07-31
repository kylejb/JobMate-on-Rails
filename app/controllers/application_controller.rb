class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    add_flash_types :info, :error, :warning, :success

    helper_method :logged_in?, :current_user
  
    def logged_in?
        !!current_user
    end

    def authorized
        redirect_to new_session_path unless self.logged_in?
    end

    private

    def current_user
        @_current_user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
    end
end
