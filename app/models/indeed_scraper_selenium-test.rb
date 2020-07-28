require 'selenium-webdriver'
# require 'webdriver-user-agent'


# Alternative to handling pop-up when browsing listings
# driver = Webdriver::UserAgent.driver(:browser => :chrome, :agent => :iPad, :orientation => :portrait)
driver = Selenium::WebDriver.for :chrome
driver.navigate.to "https://www.indeed.com/jobs?q=software+engineer&l=New+York%2C+NY"
wait_15 = Selenium::WebDriver::Wait.new(:timeout => 15)
wait = Selenium::WebDriver::Wait.new(:timeout => 5)

titles = []
companies = []
locations = []
links = []
salaries = []
descriptions = []

(1..10).each do |i|

    p job_card = driver.find_elements(:xpath, './/table[(@class="jobCard_mainContent")]').map(&:text)

    job_card.each do |job|
        begin
            location = job.find_elements(:xpath, './/span[starts-with(@class,"companyLocation")]').map(&:text)
            title  = job.find_elements(:xpath, './/h2[@class="jobTitle"]//a').map(&:text)

        rescue => exception
            location = "None"
            title = job.find_elements(:xpath, './/h2[@class="jobTitle"]//a').attribute(name="title")

        end
        p location
        locations.push(location)
        titles.push(title)
        links.push(job.find_elements(:xpath, './/h2[@class="title"]//a').attribute(name="href"))
        companies.push(job.find_elements(:xpath, './/span[@class="company"]')).map(&:text)
    end
    
    begin
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
        next_page = driver.find_element(:xpath, "//a[@aria-label=#{i+1}]//span[@class='pn']")
            #close_popup = driver.find_elements(:id, "popover-background")
        next_page.click
        #close_popup = driver.find_element(:xpath, './/div[@id="popover-background"]')
    

    rescue => exception
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
        sleep 1
        #class="icl-Icon icl-Icon--sm  icl-Icon--black close" OR popover-heading-container'
        close_popup = driver.find_elements(:xpath, '//a[@aria-label="Close"]//div[@class="icl-Icon icl-Icon--sm  icl-Icon--black close"]')
        sleep 2
       # close_popup.click
        sleep 1
        next_page = driver.find_element(:xpath, '//a[@aria-label="Next"]//span[@class="pn"]')
        next_page.click
        
        #aria-label="Close"

        # driver.manage.timeouts
        # next_page.click
        # close_popup = driver.find_elements(:id, "popover-background")
        # driver.clickElement(close_popup)

    end
    puts "Page: #{i}"
end


# jobs = wait.until {
#     ele_1 = driver.find_element(:css, ".jobsearch-SerpJobCard")
# }

#puts jobs.text
p titles
driver.quit