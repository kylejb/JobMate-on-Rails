class UserCategoriesController < ApplicationController

    def choose_categories
        @user_category = UserCategory.new
    end

    def set_categories
      
    end
    
    def create 
      @category = Category.find(params[:id])
      @user_category = UserCategory.create(user: current_user, category: @category)
    end

end
