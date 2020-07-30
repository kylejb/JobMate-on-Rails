namespace :db do
    desc "Extract years from description column to years column with regex"
    task :posting_parser => :environment do
        
        Posting.all.each { |a_post| a_post.experience.update(experience: a_post.extract_experience) unless !!a_post.experience }
                
    end
end