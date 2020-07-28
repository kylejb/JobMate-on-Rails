# require 'open-uri'
# require 'nokogiri'
# require 'mechanize'
require 'kimurai'

class IndeedScraper < Kimurai::Base
    @name = 'ind_job_scraper'
    @start_urls = ["https://www.indeed.com/jobs?q=software+engineer&l=New+York%2C+NY&sort=date&fromage=14"]
    @engine = :selenium_chrome

    @@jobs = []

    def self.all
        @@jobs
    end

    def scrape_page
        doc = browser.current_response
        returned_jobs = doc.css('td#resultsCol')
        returned_jobs.css('div.jobsearch-SerpJobCard').each do |char_element|
          # scraping individual listings 
          title = char_element.css('h2 a')[0].attributes["title"].value.gsub(/\n/, "")
          link = "https://indeed.com" + char_element.css('h2 a')[0].attributes["href"].value.gsub(/\n/, "")
          description = char_element.css('div.summary').text.gsub(/\n/, "")
          company = description = char_element.css('span.company').text.gsub(/\n/, "")
          location = char_element.css('div.location').text.gsub(/\n/, "")
          salary = char_element.css('div.salarySnippet').css('span.salaryText').text.gsub(/\n/, "")
          requirements = char_element.css('div.jobCardReqContainer').text.gsub(/\n/, "")
          # creating a job object
          job = {title: title, link: link, description: description, company: company, location: location, salary: salary, requirements: requirements}
        
          # adding the object if it is unique
          #! test with byebug to see if include is behaving correctly//'find_by'
          @@jobs << job if !@@jobs.include?(job)
        end
    end

    def parse(response, url:, data: {})
         # scrape first page
        scrape_page
        # next page link starts with 10 so the counter will be initially set to 1
        num = 1
        #visit next page and scrape it
        # TODO - make this run until end
        10.times do
            browser.visit("https://www.indeed.com/jobs?q=software+engineer&l=New+York%2C+NY&sort=date&fromage=14&start=#{num}0")
            scrape_page
            num += 1
        end
        @@jobs
    end
end
IndeedScraper.crawl!


# Thanks to https://www.scrapingbee.com/blog/web-scraping-ruby/#kimurai-setup