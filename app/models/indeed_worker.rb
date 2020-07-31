require 'selenium-webdriver'
# require 'webdriver-user-agent'
class IndeedWorker

  def rescue_exceptions
      begin
        yield
      rescue Selenium::WebDriver::Error::NoSuchElementError
        false
      rescue Selenium::WebDriver::Error::StaleElementReferenceError
        false
      end
  end

  def run(urls = ["https://indeed.com/pagead/clk?mo=r&ad=-6NYlbfkN0AGUMwYHCTVR_X2MgN4SXeYX14c_JDhoO_O4mb3K3QTCZzznso5xFyDDZLBeKYE_u604XRBVCy9LQWR9wW3hHRdNXN7BEhfx5H7cAJh7bpwkXw3F7Nm1otZuTIroWpATTyYzece4ij8IRq7msOkHkr5saL8eQ9cbS6J3Ysj-mjR7K6o39ORhDdOWVbdHrAPlSeUwir5mX9dVR5UlSXMujz7Xce7akV767AbOoVabHAv_rWU-yN7Gi8RMZZZ3sPblmCpaW4bLlHDuOl7VtGMlJUBBxmNewLmgAicn49o8vGZ6PZ2T9NYmxQ3csiktq-wYr2dfcLghVnO0zY0voQR7uOzny9KznKQD_C0GyY2jitknDUBTW9pV2AtPW9NapLFK_tsOb8xPu_8jDSwNIS9Vs8VZxLbYCmpQzAZJc9HqFso1BnlNZGLHH4bmKE33o8j3SZ5-jQIeJkDAfVq25-JgrO7&p=0&fvj=1&vjs=3" ])
    
    #setup
    driver = Selenium::WebDriver.for :chrome
    wait = Selenium::WebDriver::Wait.new(:timeout => 1000)

    #login flow

    # form url that will be passed
    apply_urls = [urls]
    byebug
    # TODO- can this help web scraping tool to get us more data?

    begin
    driver.get 'https://secure.indeed.com/account/login'
    puts "Loading Indeed Sign-in Page..."

    sleep rand(1..4)
    driver.find_element(id: 'login-email-input').send_keys('naxoeubxeujyywskgs@ttirv.org')
    sleep rand(1..5)
    driver.find_element(id: 'login-password-input').send_keys('jakb2020fS')
    puts "Complete reCAPTCHA and login"
    puts "Notice: System will wait one minute before continuing process."
    sleep 60
    apply_urls.each do |url|
        driver.navigate.to url 
        sleep 2
        driver.find_element(:xpath, "//button[@class='icl-Button icl-Button--branded icl-Button--md']").click # (class: 'icl-Button').submit
        sleep 3

        #? try for line 44 --> div.id='ia-container OR div.class=indeed-apply-popup // currently unable to locate 'iframe'
        # iframe = driver.find_element(:css, 'iframe')
        # driver.switch_to.frame 'iframe'
        driver.find_element(:tag_name, 'button').click #'form-action-continue').submit
        driver.switch_to.default_content
        # element = wait.until do 
        #   driver.action.key_down(:control).perform.nil? #(:class, "form-action-continue")
        # end
        # driver.action.key_up(:control).perform

        # driver.find_element(id: 'form-action-continue').submit
        # sleep 3
        # driver.find_element(id: 'form-action-continue').submit
        # sleep 3

        # driver.find_element(id: 'form-action-continue').submit
        # sleep 3
        # sleep 60
        # ia-ApplyFormScreen
    end
    ensure
      driver.quit
    end
  end
end