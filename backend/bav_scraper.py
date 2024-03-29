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
        self.driver = webdriver.Chrome("/usr/local/bin/chromedriver",options=chrome_options)
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

    def get_data(self):
        self.driver.execute_script("window.scrollBy(0,200)")
        self.screenshot = self.driver.find_element_by_xpath('//*[@id="body"]/section/div/div/div/div[2]/div[4]').screenshot_as_base64
        self.nettoAufwand = self.driver.find_element_by_xpath('//*[@id="body"]/section/div/div/div/div[2]/div[2]/div[9]/div/div[12]/label').text
        
        bav = int(self.bAV)
        self.nettoAufwand = self.nettoAufwand[:-2].replace(",",".")
        self.steuerErsparnis = str(round(float(bav - float(self.nettoAufwand)),2))

    def execute_bot(self):
        self.automate_inputs()
        self.click_button()
        self.get_data()
        print("executed_bot")
