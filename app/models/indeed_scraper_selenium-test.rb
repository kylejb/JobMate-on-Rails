require 'selenium-webdriver'


driver = Selenium::WebDriver.for :chrome
driver.navigate.to "https://www.indeed.com/jobs?q=software+engineer&l=New+York%2C+NY"
wait = Selenium::WebDriver::Wait.new(:timeout => 20)
jobs = wait.until {
    ele_1 = driver.find_element(:css, ".jobsearch-SerpJobCard")
}

puts jobs.text