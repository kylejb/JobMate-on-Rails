# require 'open-uri'
# require 'nokogiri'
# require 'mechanize'
require 'kimurai'

class IndeedScraper < Kimurai::Base
    @name = 'ind_job_scraper'
    @start_urls = ["https://www.indeed.com/jobs?q=software+engineer&l=New+York%2C+NY&sort=date&fromage=14"]
    @engine = :selenium_chrome

    # @@jobs = []

    # def self.all
    #     @@jobs
    # end

    def parse(response, url:, data: {})
        # scrape first page
       scrape_page
       # next page link starts with 10 so the counter will be initially set to 1
       num = 1
       #visit next page and scrape it
       # TODO - make this run until end
       2.times do
           browser.visit("https://www.indeed.com/jobs?q=software+engineer&l=New+York%2C+NY&sort=date&fromage=14&start=#{num}0")
           scrape_page
           num += 1
       end
    #    @@jobs
    end

    def scrape_page
        doc = browser.current_response
        returned_jobs = doc.css('td#resultsCol')
        count = 0
        returned_jobs.css('div.jobsearch-SerpJobCard').each do |char_element|
        link = "https://indeed.com" + char_element.css('h2 a')[0].attributes["href"].value.gsub(/\n/, "")
           
            # boolean check for existence in our db before stepping into char_ele
            # TODO - refactor to leverage rails validation
            #? uncomment line 42 for more robustness to prevent duplicates? // how can this be refactored?
            if !Posting.find_by(link: link) #&& !(Posting.find_by(title: title, company: Company.find_by(name: company)))
                # scraping individual listings 
                title = char_element.css('h2 a')[0].attributes["title"].value.gsub(/\n/, "")
                div_summary  = char_element.css('div.summary').text.gsub(/\n/, "")
                company = div_summary = char_element.css('span.company').text.gsub(/\n/, "")
                # Model Validaton Implemented
                company_obj = Company.find_or_create_by(name: company)
                # click on link and extract description, salary, and location
                browser.visit(link)
                job_page = browser.current_response
                description = job_page.xpath('/html/body/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[5]/div[2]').text
                # TODO - refactor to relative-xpath-routing to capture other edge cases?
                if description == ""
                    description = job_page.xpath('/html/body/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[6]/div[2]').text
                end
                ## creating a job object
                # refactor with mass_assignment
                # job = {title: title, link: link, description: description, company: company_obj} #, location: location, salary: salary, languages: languages, experience: experience, requirements: requirements}
                Posting.create(title: title, link: link, description: description, company: company_obj)
            end

        #   description = char_element.css('div.summary').text.gsub(/\n/, "")
        #   location = char_element.css('div.location').text.gsub(/\n/, "")
        #   salary = char_element.css('div.salarySnippet').css('span.salaryText').text.gsub(/\n/, "")
        #   requirements = char_element.css('div.jobCardReqContainer').text.gsub(/\n/, "")

        # adding the object if it is unique
        # @@jobs << job if !@@jobs.include?(job)
        p count += 1
        end
        puts "There are #{count} jobs."
    end
end

IndeedScraper.crawl!


# Thanks to https://www.scrapingbee.com/blog/web-scraping-ruby/#kimurai-setup