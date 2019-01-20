require "selenium-webdriver"

#caps = Selenium::WebDriver::Remote::Capabilities.chrome
# http://chromedriver.chromium.org/capabilities
caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {
    "args" => [
         '--disable-popup-blocking',
         '--disable-feature=TranslateUI',
         '--disable-infobars',
         '--start-fullscreen',
         '--start-maximized',
         '--kiosk'
        ]
        })

driver = Selenium::WebDriver.for :remote, url: "http://192.168.33.10:9515", desired_capabilities: caps

load ARGV[0]
handler(driver)
