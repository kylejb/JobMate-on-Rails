require 'kimurai'

class IndeedScraper < Kimurai::Base

    # Future feature: allow dynamic passing of search queries
    BASE_URL = "https://www.indeed.com/jobs?q="
    # For BASE_QUERY, at minimum we could create a custom method to replace '+' with ' '.
    BASE_QUERY = "software+engineer"
    BASE_LOCATION = "&l=New+York%2C+NY"
    BASE_SORT = "&sort=date&fromage=14"


    @name = 'ind_job_scraper'
    @start_urls = [BASE_URL+BASE_QUERY+BASE_LOCATION+BASE_SORT]
    @engine = :selenium_chrome

    def parse(response, url:, data: {})
        # scrape first page
       scrape_page
       # next page link starts with 10 so the counter will be initially set to 1
       num = 1
       #visit next page and scrape it
       # TODO - make this run until end
       2.times do
           browser.visit("https://www.indeed.com/jobs?q=software+engineer&l=New+York%2C+NY&sort=date&fromage=14&start=#{num}0")
           puts "Parsing jobs on page number: #{num}"
           scrape_page
           num += 1
       end
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
                
                # parse out years of experience from description for persistence in separate column
                experience = years_in_description(description)

                ## creating a job object
                # refactor with mass_assignment
                # job = {title: title, link: link, description: description, company: company_obj} #, location: location, salary: salary, languages: languages, experience: experience, requirements: requirements}
                Posting.create(title: title, link: link, description: description, company: company_obj, experience: experience)
            end       
        p count += 1
        end
        puts "I have read #{count} jobs on this page"
    end

    # helper method to parse description string
    def years_in_description(description)
        description.match(/[\d ()+]+(?:^|\W)years(?:$|\W)/)
    end
end

IndeedScraper.crawl!


# Special thanks to 'https://www.scrapingbee.com/blog/web-scraping-ruby/#kimurai-setup' for code/guidance.