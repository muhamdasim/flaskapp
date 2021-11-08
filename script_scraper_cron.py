from datetime import timedelta
from flask import Flask, jsonify, render_template, request
from os import removedirs
from MySQLdb import Connect, connect
from flask import Flask, config, render_template, request, redirect, url_for, session, flash
from flask.helpers import flash
from flask.typing import ResponseReturnValue
from flask_mysqldb import MySQL
import MySQLdb.cursors
import re
from flask_mail import Mail, Message
import stripe
import os
import datetime
import random
import string
import time
import smtplib
import pandas as pd
from selenium import webdriver
from flask import Flask
from selenium.webdriver.chrome.options import Options
from waitress import serve
from selenium import webdriver
from selenium.webdriver.common.keys import Keys



stripe_keys = {
  'secret_key': 'sk_test_51JpGWQChgKx4d8ZkeQGxPCSyMNlNUZ3P8PTOKNs7ITsNmdEqlJle6uN4okQaWz1LngjYrj8YXh3Qq8GwQ152sFGW00CTA825OA',
  'publishable_key':'pk_test_51JpGWQChgKx4d8ZkYMn6qdxfVaPZ3WfVHMhjF3QS5zDgZ214XJea9jPDGFukWXPBjLRxlzsklEheH7vCeYimlljF00zvSYeocw'
}


domain_url="http://18.216.203.31:8080"
stripe.api_key = stripe_keys['secret_key']



app = Flask(__name__)
app.secret_key = "Secret Key"

# Mysql db config

app.config['MYSQL_HOST'] = 'database-1.cj217kicihvy.us-east-2.rds.amazonaws.com'
app.config['MYSQL_PORT']=3306
app.config['MYSQL_USER'] = 'admin'
app.config['MYSQL_PASSWORD'] = 'Codeaza21'
app.config['MYSQL_DB'] = 'flaskapp'

# Intialize MySQL
mysql = MySQL(app)
mail_settings = {
    "MAIL_SERVER": 'smtp.gmail.com',
    "MAIL_PORT": 465,
    "MAIL_USE_TLS": False,
    "MAIL_USE_SSL": True,
    "MAIL_USERNAME": 'gamingtricks9@gmail.com',
    "MAIL_PASSWORD": 'pakistan02'
}

app.config.update(mail_settings)
mail = Mail(app)
app.config.update(mail_settings)
mail = Mail(app)


key = random.randint(1,20)
letters = string.ascii_lowercase
final_key = ''.join(random.choice(letters) for i in range(key))

@app.route('/_add_numbers')
def add_numbers():
    a = request.args.get('a', 0, type=int)
    b = request.args.get('b', 0, type=int)
    return jsonify(result=a + b)

def script ():
    email = "harrissmanzoor22@gmail.com"
    msg = Message('Hello from the other side!', sender = 'flask@codeaza-apps.com', recipients = email)
    url = domain_url+"/adminlogin/password?id="
    final = url + final_key
    with app.app_context():
        msg  = Message(
        subject="Hello",
        sender = app.config.get("MAIL_USERNAME"),
        recipients=[email],
        body = final)
    mail.send(msg)
    return

    options = Options()
    options.add_argument("--headless")
    options.add_argument("--disable-gpu")
    options.add_argument("--no-sandbox")
    options.add_argument("enable-automation")
    options.add_argument("--disable-infobars")
    options.add_argument("--disable-dev-shm-usage")
    driver = webdriver.Chrome(options=options, executable_path='/usr/bin/chromedriver')
    keyword = "restraunts in e11/2 islamabad"
    url = "https://www.google.com/search?q=" + keyword + "&tbm=lcl&oq=" + keyword
    driver.get(url)
    driver.execute_script("window.open('');")
    driver.switch_to.window(driver.window_handles[0])
    rows = []
    while True:
        nodes = driver.find_elements_by_xpath('//div[@jsaction]/div[contains(@id,"tsuid")]//div[@role="heading"]')
        for i in range(1, len(nodes)):
            driver.switch_to.window(driver.window_handles[0])
            try:
                driver.find_element_by_xpath(
                    '//div[@jsaction]/div[contains(@id,"tsuid")][' + str(i) + ']//div[@role="heading"]').click()
            except:
                continue
            time.sleep(random.randint(6, 10))
            title = "";
            website = "";
            phone = "";
            street = "";
            city = "";
            state = "";
            zip = "";
            country = "";
            address = "";
            noOfPhotos = ""

            title = driver.find_element_by_xpath("//h2/span").text
            try:
                phone = driver.find_element_by_xpath(
                    '//div[@data-attrid="kc:/collection/knowledge_panels/has_phone:phone"]//span[2]').text
            except:
                pass
            try:
                website = driver.find_element_by_xpath("//div[@lang]//a[@role='button'][@ping]").get_attribute('href')
            except:
                pass
            try:
                address = driver.find_element_by_xpath(
                    '//div[@data-attrid="kc:/location/location:address"]//span[2]').text
            except:
                pass
            try:
                street = address.split(',')[0]
            except:
                pass
            try:
                city = address.split(',')[1]
            except:
                pass
            try:
                state = address.split(',')[2].strip().split(' ')[0]
            except:
                pass
            try:
                zip = address.split(',')[2].strip().split(' ')[1]
            except:
                pass
            try:
                country = address.split(',')[-1]
            except:
                pass
            photoUrl = ""
            try:
                photoUrl = driver.find_element_by_xpath(
                    '//div[@data-attrid="kc:/location/location:media"]/div/a[1]').get_attribute('href')
            except:
                pass
            if photoUrl != '':
                driver.switch_to.window(driver.window_handles[1])
                driver.get(photoUrl)
                time.sleep(random.randint(3, 10))
                try:
                    driver.execute_script("arguments[0].click()",
                                          driver.find_element_by_xpath("//div[text()='Street View & 360°']"))
                except:
                    print(title + ' business has not Street View and 360 images')
                    noOfPhotos = 0
                    row = [title, phone, website, address, street, city, state, zip, country, noOfPhotos]
                    rows.append(row)
                    continue
                time.sleep(random.randint(5, 7))
                try:
                    imagesCount = driver.find_elements_by_xpath(
                        '//div[@class="widget-pane widget-pane-visible"]/div/div/div/div[3]/div[@jsan]//a')
                    print(title + ' business has ' + str(len(imagesCount)) + ' Street View and 360 images')
                except:
                    print(title + ' business has ' + str(len(imagesCount)) + ' Street View and 360 images')
                    noOfPhotos = 0
                if len(imagesCount) > 1:
                    print(title + ' business have more than Street View and 360 images')
                    continue
                else:
                    noOfPhotos = len(imagesCount)
                    row = [title, phone, website, address, street.strip(), city.strip(), state.strip(), zip.strip(),
                           country.strip(), noOfPhotos]
                    rows.append(row)
                    print(row)
            else:
                continue
        try:
            driver.switch_to.window(driver.window_handles[0])
            driver.find_element_by_id("pnnext").click()
            time.sleep(random.randint(5, 10))
        except:
            break

    df = pd.DataFrame(rows, columns=['Title', 'Phone', 'Website', 'Address', 'Street', 'City', 'State', 'Zip', 'Country',
                                  'No_of_Photos'])
    df.to_csv(keyword.replace("'", "").replace('"', '"').replace("/", "").replace("\\", "") + '.csv', index=False,
              encoding='utf-8-sig')
    print('All business has been scraped')
    driver.quit()
    return df.to_string()
    #driver.get("https://www.google.com/")
    #element_text = driver.page_source
    #driver.quit()
    #return element_text






if __name__ == "__main__":
    script()
