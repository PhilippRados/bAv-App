from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import time
import requests

chrome_options = Options()
chrome_options.add_argument("--headless")

class bAVBot():
    def __init__(self,Brutto,bAV,Steuerklasse):
        self.Brutto = Brutto
        self.bAV = bAV
        self.Steuerklasse = Steuerklasse
        self.driver = webdriver.Chrome("/Users/philipprados/Downloads/chromedriver",options=chrome_options)
        self.driver.get("https://rechner.selbst-rechnen.de/bAV/")


    def automate_inputs(self):
        time.sleep(1)
        #User defined fields
        element = self.driver.find_element_by_xpath(
            '//*[@id="body"]/section/div/div/div/div[2]/div[1]/form/div[2]/div/div[2]/input')
        element.clear()
        element.send_keys(self.Brutto)


        element = self.driver.find_element_by_xpath(
            '//*[@id="body"]/section/div/div/div/div[2]/div[1]/form/div[3]/div/div[2]/input')
        element.clear()
        element.send_keys(self.bAV)

        #Steuerklasse
        self.driver.find_element_by_xpath(f'//*[@id="TaxClass"]/option[{self.Steuerklasse}]').click()

        #Kirchensteuer
        self.driver.find_element_by_xpath(
            '//*[@id="body"]/section/div/div/div/div[2]/div[1]/form/div[3]/div/div[2]/input').click()
        self.driver.find_element_by_xpath(
            '//*[@id="body"]/section/div/div/div/div[2]/div[1]/form/div[8]/div/div[2]/select/option[3]').click()

        #Arbeitsort
        self.driver.find_element_by_xpath(
            '//*[@id="body"]/section/div/div/div/div[2]/div[1]/form/div[9]/div/div[2]/select/option[3]').click()

        #Wohnort
        self.driver.find_element_by_xpath(
            '//*[@id="body"]/section/div/div/div/div[2]/div[1]/form/div[10]/div/div[2]/select/option[3]').click()

        #KV-Beitrag
        element = self.driver.find_element_by_xpath(
            '//*[@id="body"]/section/div/div/div/div[2]/div[1]/form/div[14]/div/div[2]/input')
        element.clear()
        element.send_keys('15.9')

    def click_button(self):
        self.driver.find_element_by_xpath('//*[@id="body"]/section/div/div/div/div[2]/div[1]/div/div/a').click()
        time.sleep(1)

    def take_screenshot(self):
        self.driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        self.driver.find_element_by_xpath('//*[@id="body"]/section/div/div/div/div[2]/div[4]').screenshot("./../assets/graph.png")

    def execute_bot(self):
        #self.connect_to_website()
        self.automate_inputs()
        self.click_button()
        self.take_screenshot()
        print("executed_bot")
