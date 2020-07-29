namespace :app do
    desc "Scrape Indeed Job Listings by General Query"
    task :indeed_scraper => :environment do
        IndeedScraper.crawl!
    end
end