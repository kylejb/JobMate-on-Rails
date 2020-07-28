require 'open-uri'
require 'nokogiri'
require 'mechanize'


# class IndeedScraper
    # page = Nokogiri::HTML(URI.open(url))
    # jobs = page.css(".jobsearch-SerpJobCard").css(".title").text
    # pp jobs
# end

agent = Mechanize.new

# Testing the following url - in later version, we should make this dynamic to pass in user params for job title and location
url = "https://www.indeed.com/jobs?q=software+engineer&l=New+York%2C+NY&start=00"

page = agent.get(url)

another_page = true
page_num = 0

while another_page == true

    page.search('table').each do |job_link|
        job_url = job_link.attr('href')
        job_page = agent.get(job_url.to_s)

        puts job_link
        puts
        puts job_url
        puts
        puts job_page
        puts

    end

    # checks if there is a disabled right button class somewhere on the page
    disabled_right_button = page.search('div.content_body a.right.disabled')
    if disabled_right_button.any?
        another_page = false # stops the loop from running again
    else
        page = agent.get("https://www.indeed.com/jobs?q=software+engineer&l=New+York%2C+NY&start=#{page_num+1}0")
    end

    page_num += 1
end