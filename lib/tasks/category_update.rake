namespace :app do
    desc "Update list of user categories"
    task :category_update => :environment do

        CATEGORIES = [
        "Front-End Engineer", 
        "Back-End Engineer", 
        "Full-Stack Engineer", 
        "DevOps Engineer", 
        "Site Reliability Engineer", 
        "Cybersecurity Engineer",
        "Data Engineer"]


        CATEGORIES.each do |category|
            Category.create(title: category)
        end

    end
end