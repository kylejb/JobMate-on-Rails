namespace :app do
    desc "Update list of user categories"
    task :category_update => :environment do
        Category.update_categories
    end
end