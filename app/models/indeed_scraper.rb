require 'open-uri'
require 'nokogiri'
#require 'mechanize'


# class IndeedScraper


# end

 # Testing the following URL - in later version, we should make this dynamic to pass in user params for job title and location
 URL = "https://www.indeed.com/jobs?q=software+engineer&l=New+York%2C+NY&start=10"

# requesting resource
# html = URI.open(URL)
page = Nokogiri::HTML(URI.open(URL))
jobs = page.css(".jobsearch-SerpJobCard").css(".title").text
pp jobs

# def extract_job_title_from_result(noko_page)
# end