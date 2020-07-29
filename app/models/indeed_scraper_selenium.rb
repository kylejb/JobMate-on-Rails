require 'selenium-webdriver'
# require 'webdriver-user-agent'


def rescue_exceptions
    begin
      yield
    rescue Selenium::WebDriver::Error::NoSuchElementError
      false
    rescue Selenium::WebDriver::Error::StaleElementReferenceError
      false
    end
end

#setup
driver = Selenium::WebDriver.for :chrome
wait = Selenium::WebDriver::Wait.new(:timeout => 10)

#login flow


#form url that will be passed
apply_urls = ["https://indeed.com/pagead/clk?mo=r&ad=-6NYlbfkN0AGUMwYHCTVR_X2MgN4SXeYX14c_JDhoO_O4mb3K3QTCZzznso5xFyDDZLBeKYE_u604XRBVCy9LQWR9wW3hHRdNXN7BEhfx5H7cAJh7bpwkXw3F7Nm1otZuTIroWpATTyYzece4ij8IRq7msOkHkr5saL8eQ9cbS6J3Ysj-mjR7K6o39ORhDdOWVbdHrAPlSeUwir5mX9dVR5UlSXMujz7Xce7akV767AbOoVabHAv_rWU-yN7Gi8RMZZZ3sPblmCpaW4bLlHDuOl7VtGMlJUBBxmNewLmgAicn49o8vGZ6PZ2T9NYmxQ3csiktq-wYr2dfcLghVnO0zY0voQR7uOzny9KznKQD_C0GyY2jitknDUBTW9pV2AtPW9NapLFK_tsOb8xPu_8jDSwNIS9Vs8VZxLbYCmpQzAZJc9HqFso1BnlNZGLHH4bmKE33o8j3SZ5-jQIeJkDAfVq25-JgrO7&p=0&fvj=1&vjs=3" ]


begin
    driver.get 'https://secure.indeed.com/account/login'
    puts "Loading Indeed Sign-in Page..."

    sleep 1
    driver.find_element(id: 'login-email-input').send_keys('naxoeubxeujyywskgs@ttirv.org')
    sleep 1
    driver.find_element(id: 'login-password-input').send_keys('jakb2020fS')
    puts "Complete reCAPTCHA and login"
    puts "Notice: System will wait one minute before continuing process."
    sleep 60
    apply_urls.each do |url|
        driver.navigate.to url 
        sleep 2
        driver.find_element(:xpath, "//button[@class='icl-Button icl-Button--branded icl-Button--md']").click #(class: 'icl-Button').submit
        sleep 3
        driver.find_element(id: 'form-action-continue').submit
        sleep 3
        element = wait.until { driver.find_element(:class, "form-action-continue") }
        element.click
        driver.find_element(id: 'form-action-continue').submit
        sleep 3
        driver.find_element(id: 'form-action-continue').submit
        sleep 3


        sleep 60
    end

    ia-ApplyFormScreen

ensure
    driver.quit
end

















# class IndeedApplyWorker

#     attr_reader :driver

#     def setup
#         @driver = Selenium::WebDriver.for :chrome
#     end
      
#     def teardown
#         @driver.quit
#     end

#     # def wait
#     #     Selenium::WebDriver::Wait.new(:timeout => 10)
#     # end
    
    
#     # def rescue_exceptions
#     #     begin
#     #       yield
#     #     rescue Selenium::WebDriver::Error::NoSuchElementError
#     #       false
#     #     rescue Selenium::WebDriver::Error::StaleElementReferenceError
#     #       false
#     #     end
#     # end
    
#     def is_displayed?(locator = {})
#         rescue_exceptions { @driver.find_element(locator).displayed? }
#     end
    
#     # def run
#     #     setup
#     #     access_and_action(@driver)
#     #     teardown
#     # end
    
#     def is_in_deed?
#         ## if one of the below, then proceed with logic; otherwise, login(driver)... then logic.
#         # div.class gnav-LoggedOutAccountLink #? signed out
#         # div.class gnav-MenuToggle-label #* signed in
#     end
    
    
    
#     def access_and_action(driver, apply_urls = [])
#         wait = Selenium::WebDriver::Wait.new

#         apply_urls = ["https://indeed.com/pagead/clk?mo=r&ad=-6NYlbfkN0AGUMwYHCTVR_X2MgN4SXeYX14c_JDhoO_O4mb3K3QTCZzznso5xFyDDZLBeKYE_u604XRBVCy9LQWR9wW3hHRdNXN7BEhfx5H7cAJh7bpwkXw3F7Nm1otZuTIroWpATTyYzece4ij8IRq7msOkHkr5saL8eQ9cbS6J3Ysj-mjR7K6o39ORhDdOWVbdHrAPlSeUwir5mX9dVR5UlSXMujz7Xce7akV767AbOoVabHAv_rWU-yN7Gi8RMZZZ3sPblmCpaW4bLlHDuOl7VtGMlJUBBxmNewLmgAicn49o8vGZ6PZ2T9NYmxQ3csiktq-wYr2dfcLghVnO0zY0voQR7uOzny9KznKQD_C0GyY2jitknDUBTW9pV2AtPW9NapLFK_tsOb8xPu_8jDSwNIS9Vs8VZxLbYCmpQzAZJc9HqFso1BnlNZGLHH4bmKE33o8j3SZ5-jQIeJkDAfVq25-JgrO7&p=0&fvj=1&vjs=3" ]
#         run do
#             driver.get 'https://secure.indeed.com/account/login'
#             puts "Loading Indeed Sign-in Page..."
#             sleep 1
#             driver.find_element(id: 'login-email-input').send_keys('naxoeubxeujyywskgs@ttirv.org')
#             sleep 2
#             driver.find_element(id: 'login-password-input').send_keys('jakb2020fS')
        
#             sleep 1
#             while true
#                 begin 
#                     driver.find_element(id: 'login-submit-button').submit
#                     #driver.find_element(id: 'rc-anchor-container')
#                     # sleep/wait until user passes the reCaptica MANUALLY
#                     break
#                 rescue
#                     wait.until {
#                         driver.find_element(id: "gnav-MenuToggle-label")
#                     }
#                     break
#                 end
#             end
#             #expect.is_displayed?(id: 'login-submit-button').to eql false
             

#             apply_urls.each do |url|
#                 driver.navigate.to url 
#                 sleep 2
#                 driver.find_element(class: 'jobsearch-IndeedApplyButton-buttonWrapper').submit
#                 sleep 1
#                 driver.find_element(id: 'form-action-continue').submit
#             end
#             #@driver.navigate.to "https://www.indeed.com/jobs?q=software+engineer&l=New+York%2C+NY"
#             #@driver.wait 
#             #expect(is_displayed?(id: 'login-submit-button')).to eql false
#         end
#     end
# #end


# apply action on indeed

# div id ia-ApplyFormScreen || popup to apply with indeed resume
# div id form-action-continue || continue button


# # Alternative to handling pop-up when browsing listings
# # driver = Webdriver::UserAgent.driver(:browser => :chrome, :agent => :iPad, :orientation => :portrait)
# driver = Selenium::WebDriver.for :chrome
# driver.navigate.to "https://www.indeed.com/jobs?q=software+engineer&l=New+York%2C+NY"
# wait_15 = Selenium::WebDriver::Wait.new(:timeout => 15)

# titles = []
# companies = []
# locations = []
# links = []
# salaries = []
# descriptions = []

# # helper: error handling // Credit: https://stackoverflow.com/a/13689535
# def is_element_present(how, what)
#     driver.manage.timeouts.implicit_wait = 0
#     result = driver.find_elements(how, what).size > 0
#     if result
#         result = driver.find_element(how, what).displayed?
#     end
#     driver.manage.timeouts.implicit_wait = 30
#     return result
# end

# def login(driver)
#     driver.get("https://secure.indeed.com/account/login")
#     wait = Selenium::WebDriver::Wait.new(:timeout => 10)

#     while true
#         begin 
#             driver.wait.until {
#                 ExpectedConditions.is_element_present(:xpath, '/html/body/div[1]/div[1]/main/div/div/div/section')
#             }
#     end
# end

# def go_to_listings(driver)
# end

# def aggregate_urls(driver)
# end

# def fetch_urls
#     driver = Selenium::WebDriver.for :chrome
#     success = login(driver)

# end

# (1..10).each do |i|

#     p job_card = driver.find_elements(:xpath, './/table[(@class="jobCard_mainContent")]').map(&:text)

#     job_card.each do |job|
#         begin
#             location = job.find_elements(:xpath, './/span[starts-with(@class,"companyLocation")]').map(&:text)
#             title  = job.find_elements(:xpath, './/h2[@class="jobTitle"]//a').map(&:text)

#         rescue => exception
#             location = "None"
#             title = job.find_elements(:xpath, './/h2[@class="jobTitle"]//a').attribute(name="title")

#         end
#         p location
#         locations.push(location)
#         titles.push(title)
#         links.push(job.find_elements(:xpath, './/h2[@class="title"]//a').attribute(name="href"))
#         companies.push(job.find_elements(:xpath, './/span[@class="company"]')).map(&:text)
#     end
    
#     begin
#         driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
#         next_page = driver.find_element(:xpath, "//a[@aria-label=#{i+1}]//span[@class='pn']")
#             #close_popup = driver.find_elements(:id, "popover-background")
#         next_page.click
#         #close_popup = driver.find_element(:xpath, './/div[@id="popover-background"]')
    

#     rescue => exception
#         driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
#         sleep 1
#         #class="icl-Icon icl-Icon--sm  icl-Icon--black close" OR popover-heading-container'
#         close_popup = driver.find_elements(:xpath, '//a[@aria-label="Close"]//div[@class="icl-Icon icl-Icon--sm  icl-Icon--black close"]')
#         sleep 2
#        # close_popup.click
#         sleep 1
#         next_page = driver.find_element(:xpath, '//a[@aria-label="Next"]//span[@class="pn"]')
#         next_page.click
        
#         #aria-label="Close"

#         # driver.manage.timeouts
#         # next_page.click
#         # close_popup = driver.find_elements(:id, "popover-background")
#         # driver.clickElement(close_popup)

#     end
#     puts "Page: #{i}"
# end


# # jobs = wait.until {
# #     ele_1 = driver.find_element(:css, ".jobsearch-SerpJobCard")
# # }

# #puts jobs.text
# p titles
# driver.quit