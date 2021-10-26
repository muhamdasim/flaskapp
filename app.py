from datetime import timedelta
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
import smtplib
import stripe
from selenium import webdriver
from flask import Flask
from selenium.webdriver.chrome.options import Options
from waitress import serve
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from script import *


stripe_keys = {
  'secret_key': 'sk_test_51JnTbFCUIpk7YY0L01uzn5KOaoG14oezlRsdEl7s7sXmEuemOVksGL9OM1JmPqLtDzfblmeEvlUXUNbH4RTq9jo900rfWufkHt',
  'publishable_key':'pk_test_51JnTbFCUIpk7YY0L8R45RnMglBNzNLgVnzQelIXCKDkw0u7wjEeuahProMWadhmjkffEmwkTFdzUCSRrZbMlzIAm00mOZGld3t'
}



stripe.api_key = stripe_keys['secret_key']



app = Flask(__name__)
app.secret_key = "Secret Key"

# Mysql db config

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'codeeeml_flask'
app.config['MYSQL_PASSWORD'] = 'Meseoadmin@21'
app.config['MYSQL_DB'] = 'codeeeml_flask'

# Intialize MySQL
mysql = MySQL(app)


# Email configuration

mail_settings = {
    "MAIL_SERVER": 'mail.codeaza-apps.com',
    "MAIL_PORT": 587,
    "MAIL_USE_TLS": False,
    "MAIL_USE_SSL": False,
    "MAIL_USERNAME": 'flask@codeaza-apps.com',
    "MAIL_PASSWORD": 'Meseoadmin@21'
}

app.config.update(mail_settings)
mail = Mail(app)
app.config.update(mail_settings)
mail = Mail(app)


# Stripe integration


#email reset key


key = random.randint(1,20)
letters = string.ascii_lowercase
final_key = ''.join(random.choice(letters) for i in range(key))




@app.route("/" , methods=['POST', 'GET'])
def home():

    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT * from testimonials")
    data = cursor.fetchall()
    return render_template('index.html' , data=data)

@app.route('/pricing')
def price():

    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT id ,name,description,price,discount, ROUND((price*12)-(price*12*discount*0.01),2) as yearly FROM plans")
    plans = cursor.fetchall()
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT * from testimonials")
    data = cursor.fetchall()
    return render_template ('pricing.html' , plans=plans , data= data)



@app.route('/adminlogin' , methods=['POST', 'GET'])
def login():
    # Output message if something goes wrong...
    msg = ''
    # Check if "username" and "password" POST requests exist (user submitted form)
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        # Create variables for easy access
        username = request.form['username']
        password = request.form['password']
        # Check if account exists using MySQL
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM admin WHERE username = %s AND password = %s', (username, password,))
        # Fetch one record and return result
        admin = cursor.fetchone()
        # If account exists in accounts table in out database
        if admin:
            session['loggedin'] = True
            session['id'] = admin['id']
            session['username'] = admin['username']

            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute("select IF(ISNULL(subquery.payment),0,subquery.payment) total from (SELECT sum(IF(invoices.duration>12, plans.discount*0.01*plans.price*invoices.duration, plans.price*invoices.duration)) payment from invoices inner join plans on invoices.plan_id= plans.id where month(invoices.date) = month(CURRENT_TIMESTAMP)) as subquery;")
            plans = cursor.fetchall()
            return redirect(url_for('adminhome'))

        else:
            # Account doesnt exist or username/password incorrect
            flash ("Incorrect username/password!" , "info")
            return redirect(url_for('login'))

    # Show the login form with message (if any)
    return render_template('adminlogin.html')


#- this will be the home page, only accessible for admin
@app.route('/admin')
def adminhome():
    # Check if user is loggedin
    if 'loggedin' in session:
        # User is loggedin show them the home page
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("select IF(ISNULL(subquery.payment),0,subquery.payment) total from (SELECT sum(IF(invoices.duration>12,ROUND( plans.discount*0.01*plans.price*invoices.duration,2), plans.price*invoices.duration)) payment from invoices inner join plans on invoices.plan_id= plans.id where month(invoices.date) = month(CURRENT_TIMESTAMP)) as subquery;")
        t_month = cursor.fetchone()
        cursor.execute("select IF(ISNULL(subquery.payment),0,subquery.payment) total from (SELECT sum(IF(invoices.duration>12,ROUND( plans.discount*0.01*plans.price*invoices.duration,2), plans.price*invoices.duration)) payment from invoices inner join plans on invoices.plan_id= plans.id) as subquery;")
        plans = cursor.fetchone()
        cursor.execute("SELECT COUNT(*) total_active_plans FROM plans where active_status=1;")
        total_active_plans = cursor.fetchone()
        cursor.execute("select count(*) total_users from users")
        total_users = cursor.fetchone()
        cursor.execute("select count(*) active_users from users where  active_status=1")
        active_users = cursor.fetchone()
        cursor.execute("select count(*) new_users from users where month(date_joined) = month(CURRENT_TIMESTAMP) and active_status=1")
        new_users = cursor.fetchone()
        return render_template('admindashboard.html', username=session['username'],  new_users = new_users ,   active_users = active_users ,  t_month = t_month ,  plans=plans , total_active_plans = total_active_plans , total_users = total_users)
    # User is not loggedin redirect to login page
    return redirect(url_for('login'))

#- this is for view profile for admin
@app.route('/admin/view/admin' , methods = ['GET', 'POST'])
def adminview():

    if 'loggedin' in session:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM admin')
        Data=cursor.fetchall()
    return render_template('edit_admin.html' , data = Data)

#- this is for adit profile for admin just password
@app.route('/admin/edit/admin' , methods = ['GET', 'POST'])
def adminedit():


    if request.method == 'POST':

        password = request.form['password']
        id = request.form['id']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("UPDATE admin set  password= %s  WHERE id = %s" ,(password,id))
        mysql.connection.commit()
        flash("Profile updated Successfully")
        return redirect(url_for('adminview'))



#- this will be the logout page for admin
@app.route('/admin/logout')
def logout():
    # Remove session data, this will log the user out
   session.pop('loggedin', None)
   session.pop('id', None)
   session.pop('username', None)
   # Redirect to login page
   return redirect(url_for('login'))


#- this will be the pricing plan page for admin
#- this will be the pricing plan page for admin
@app.route('/admin/plans',methods=["POST","GET"])
def plans():

    if 'loggedin' in session:

        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT id ,name,description, num_searches ,price,ROUND(discount,2) AS discount , ROUND((price*12)-(price*12*discount*0.01),2) as yearly FROM plans ORDER BY price ASC;')
        Data=cursor.fetchall()

    else:

        flash("Please Login First")
        return redirect(url_for('login'))

    return render_template ('plans.html',plans=Data)


#- this will display users from the database
@app.route('/admin/view/user',methods=["POST","GET"])
def showusers():
    if 'loggedin' in session:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('select users.id, users.username as username , users.email as email , plans.name plan_name, date(invoices.date) start_date,  date(DATE_ADD(invoices.date, INTERVAL invoices.duration MONTH)) end_date from users left outer join invoices on users.current_invoice= invoices.id left outer join plans on invoices.plan_id= plans.id')
        Data=cursor.fetchall()
        return render_template ('showuser.html',users=Data)
    else:

        flash("Please Login First")
        return redirect(url_for('login'))


#- Transactions/invoices
@app.route('/admin/view/invoices', methods=['GET', 'POST'])
def invoices():
    if 'loggedin' in session:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT plans.name as n, date(invoices.date) as d , plans.price*invoices.duration as t, invoices.payment_status as s,users.username as un  from users inner join invoices on users.current_invoice= invoices.id inner join plans on invoices.plan_id= plans.id;')
        Data=cursor.fetchall()
        return render_template('invoices.html' , plans = Data)
    else:

        flash("Please Login First")
        return redirect(url_for('login'))


#- this will insert users from the admin panel
@app.route('/admin/add/user',methods=["POST","GET"])
def addusers():

    if request.method == 'POST':

        username = request.form['username']
        email = request.form['email']
        password = request.form['password']

        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("SELECT id , COUNT(*) from users WHERE username=%s AND email=%s",(username,email))
        count = cursor.fetchone()
        total= (str(count['COUNT(*)']))

        if total=="0":


            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute("INSERT INTO users set username=%s, email = %s, password=%s",(username,email,password))
            mysql.connection.commit()
            flash("User Inserted Successfully")
            return redirect(url_for('showusers'))

        else:

            flash("User Already Exists")
            return redirect(url_for('showusers'))

    return redirect(url_for('showusers'))

#edit user
@app.route('/admin/edit/user/',methods=["POST","GET"])
def editusers():

    if request.method == 'POST':

        email = request.form['email']
        id = request.form['id']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("UPDATE users set email = %s  WHERE id =%s " ,(email,id))
        mysql.connection.commit()

        flash("User Updated")


    return redirect(url_for('showusers'))

#Delete user
@app.route('/admin/delete/user/<id>/', methods = ['GET', 'POST'])
def deleteuser(id):

    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute('DELETE FROM users WHERE id = %s' ,[id])
    mysql.connection.commit()
    flash("User Deleted Successfully")
    # return "Employee Deleted Successfully"

    return redirect(url_for('showusers'))



#this route is for inserting plan from admin dashboard to mysql database via html forms
@app.route('/admin/plans/insert', methods = ['POST'])
def insert():

    if request.method == 'POST':

        name = request.form['name']
        description = request.form['description']
        price = request.form['price']
        num_searches = request.form['num_searches']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("INSERT INTO plans set name=%s, description = %s, num_searches = %s , price=%s",(name,description, num_searches , price))
        mysql.connection.commit()

        flash("Plan Inserted Successfully")

        return redirect(url_for('plans'))

#this route is for editing plan from admin dashboard to mysql database via html forms
@app.route('/admin/plans/edit/', methods = ['GET', 'POST'])
def edit():

    if request.method == 'POST':

        name = request.form['name']
        description = request.form['description']
        price = request.form['price']
        discount = request.form['discount']
        num_searches = request.form['num_searches']
        id = request.form['id']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("UPDATE plans set  name= %s, description = %s ,  num_searches = %s , price=%s , discount = %s  WHERE id = %s" ,(name, description , num_searches ,price,discount,id))
        mysql.connection.commit()
        flash("Plan updated Successfully")
        return redirect(url_for('plans'))



#- this will be for deleting pricing plan page for admin
@app.route('/admin/plans/delete/<id>/', methods = ['GET', 'POST'])
def delete(id):

    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute('DELETE FROM plans WHERE id = %s' ,[id])
    mysql.connection.commit()
    flash("Plan Deleted Successfully")
    # return "Employee Deleted Successfully"

    return redirect(url_for('plans'))


#stripe payment integration HARIS

#ERROR------------------------------------------------------------------------------------>>>>>
@app.route('/charge', methods=['POST'])
def charge():
    amount=5
    customer = stripe.Customer.create(
        email='customer@example.com',
        source=request.form['stripeToken']
    )


    charge = stripe.Charge.create(
        customer=customer.id,
        amount=amount,
        currency='usd',
        description='Flask Charge'
    )

    cursor.execute('update invoices set payment_status = 1 where id= 3');

    return render_template('charge.html' , amount=amount )

#Admin reset email
@app.route('/adminlogin/reset',methods = ['GET', 'POST'])
def sendemail():

    if request.method == 'POST' and 'email' in request.form:
        # Create variables for easy access
        email = request.form['email']
        # Check if account exists using MySQL
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM admin WHERE email = %s ', [email])
        # Fetch one record and return result
        admin = cursor.fetchone()
        # If account exists in accounts table in out database
        if admin:
            email = admin['email']
            msg = Message('Hello from the other side!', sender = 'flask@codeaza-apps.com', recipients = email)
            url = "https://mystery.codeaza-apps.com/adminlogin/password?id="
            final = url + final_key
            with app.app_context():
                msg  = Message(
                subject="Hello",
                sender = app.config.get("MAIL_USERNAME"),
                recipients=[email],
                body = final)
            mail.send(msg)
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            ts = datetime.datetime.now()
            cursor.execute('SELECT id FROM admin WHERE email = %s',[email])
            id = cursor.fetchone()
            idInt=id['id']
            cursor.execute('INSERT INTO reset VALUES (Null , %s, %s, %s )', (final_key,ts,idInt))
            mysql.connection.commit()
            flash ("Email sent Successfully ")
            return redirect(url_for('login'))
        else:
            # Account doesnt exist or username/password incorrect
            flash ("Incorrect email" , "info")
            return redirect(url_for('login'))

    return redirect(url_for('login'))


#Admin password email
@app.route('/adminlogin/password',methods = ['POST', 'GET'])
def passwordreset():


    id = request.args.get('id')
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute('select admin_id from reset WHERE secret = %s',[id])
    sk = cursor.fetchone()
    admin_id= (str(sk['admin_id']))

    if request.method == 'POST':

        password = request.form['password']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("UPDATE admin set password = %s WHERE id = %s " , (password,admin_id))
        mysql.connection.commit()
        flash ("Password Updated Successfully ")
        return redirect(url_for('login'))

    return render_template('passwords.html',id=id)

# user routing starts from here onwards

@app.route('/userlogin' , methods=['POST', 'GET'])
def user_login():
    # Output message if something goes wrong...
    msg = ''
    # Check if "username" and "password" POST requests exist (user submitted form)
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        # Create variables for easy access
        username = request.form['username']
        password = request.form['password']
        # Check if account exists using MySQL
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM users WHERE username = %s AND password = %s', (username, password,))
        # Fetch one record and return result
        user = cursor.fetchone()
        # If account exists in accounts table in out database
        if user:
            session['loggedin'] = True
            session['id'] = user['id']
            session['username'] = user['username']
            return redirect(url_for('user_dashboard'))

        else:
            # Account doesnt exist or username/password incorrect
            flash ("Incorrect username/password!" , "info")
            return redirect(url_for('user_login'))

    # Show the login form with message (if any)
    return render_template('user_login.html')


# user routing -- redirect to register now page.
@app.route('/register' , methods=['GET', 'POST'])
def user_register():
    id = request.args.get('id', default=None, type=str)
    type=request.args.get('type',type=str)

    # Output message if something goes wrong...
    msg = ''
    # Check if "username", "password" and "email" POST requests exist (user submitted form)
    # if(id is None):
    #     return redirect(url_for('price'))
    address2=None;
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form and 'email' in request.form:# and 'firstname' in request.form and 'lastname' in request.form and 'address1' in request.form:
        # Create variables for easy access
        firstname= request.form['firstname']
        lastname= request.form['lastname']
        address1= request.form['address1']
        address2=request.form['address2']
        username = request.form['username']
        password = request.form['password']
        email = request.form['email']
        phone = request.form['phone']
        # Check if account exists using MySQL
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM users WHERE username = %s OR email = %s ', (username,email))
        account = cursor.fetchone()
        # If account exists show error and validation checks
        if account:
            flash ('Account already exists!')
            return render_template('user_register.html')
        elif not re.match(r'[^@]+@[^@]+\.[^@]+', email):
            msg = 'Invalid email address!'
        elif not re.match(r'[A-Za-z0-9]+', username):
            msg = 'Username must contain only characters and numbers!'
        elif not username or not password or not email:
            msg = 'Please fill out the form!'
        else:
            # Account doesnt exists and the form data is valid, now insert new account into accounts table
            invoice_id=None
            if(id is not None):
                cursor.execute('INSERT INTO invoices VALUES (NULL,NULL, "1", "0", current_timestamp(), "1", %s );',[id])
                invoice_id= cursor.lastrowid
            cursor.execute('INSERT INTO users VALUES (NULL, %s,%s,%s,%s,%s, %s, %s, %s , "1" , current_timestamp())', (username,firstname,lastname, address1, address2, email,password, invoice_id))
            userInserted= cursor.lastrowid
            cursor.execute('UPDATE invoices set user_id=%s where id=%s', (userInserted, invoice_id))
            mysql.connection.commit()
            flash ('You have successfully registered!' , "info" )
            return redirect(url_for('user_login'))

    elif request.method == 'POST':
        # Form is empty... (no POST data)
        msg = 'Please fill out the form!'
    # Show registration form with message (if any)
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    if type=='monthly':
        cursor.execute('SELECT name , price FROM plans WHERE id = %s', [id])
        data= cursor.fetchone()
        data['plan_id']=id
    elif type=='yearly':
        cursor.execute('SELECT name , ROUND((price*12)-(price*12*discount*0.01),2) as price FROM plans WHERE id = %s', [id])
        data= cursor.fetchone()
        data['plan_id']=id

    return render_template('user_register.html', data = data , type = type )


#- this will be the logout page for admin
@app.route('/user_home/logout')
def user_logout():
    # Remove session data, this will log the user out
   session.pop('loggedin', None)
   session.pop('id', None)
   session.pop('username', None)
   # Redirect to login page
   return redirect(url_for('user_login'))



# user routing -- redirect to user dashboard  page.

@app.route("/user_home" , methods=['GET', 'POST'])
def user_dashboard():

    if 'loggedin' in session:

        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        s_id= str(session['id'])

        cursor.execute("SELECT u.current_invoice, i.payment_status, i.active_status from users u left outer join  invoices i on i.id= u.current_invoice where u.id=%s;",[s_id])
        Data=cursor.fetchone()

        cursor.execute('SELECT CONCAT(firstname, " ", lastname) AS Name , email , phone FROM users where id=%s',[s_id])
        user=cursor.fetchone()

        cursor.execute('SELECT date(invoices.date) as date,plans.name as name ,plans.price as price from invoices INNER JOIN plans ON invoices.plan_id=plans.id where invoices.user_id= %s',[s_id])
        p=cursor.fetchone()

        if request.method == "POST":

            search = request.form['search']
            driver= driverInitialize();
            # runScraper(search, driver)


        return render_template('user_dashboard.html' ,  user = user , p = p )


    else:

        flash("Please Login First")
        return redirect(url_for('user_login'))

    return render_template('user_dashboard.html')


# user routing -- redirect to user support page.




# faqs page
@app.route('/faq')
def faq():
    return render_template('faq.html')

#user routing -- redirect to user support page.

@app.route('/user_support' , methods=['GET', 'POST'])
def user_support():

    if request.method == "POST":

        name  = request.form['name']
        email = request.form['email']
        phone = request.form['phone']
        message = request.form['message']
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO support(name,email,phone,message ) VALUES (%s, %s , %s , %s)", (name, email ,phone,message))
        mysql.connection.commit()
        flash ('Form sent successfully!' , "info" )
        return redirect(url_for('user_support'))

    return render_template('usersupport.html')

# user show transactions
@app.route('/transactions', methods=['GET', 'POST'])
def transactions():
    s_id=str(session['id'])
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute('SELECT plans.name as n, date(invoices.date) as d , plans.price*invoices.duration as t, if(invoices.active_status=1,"Active", "Inactive") as s  from users inner join invoices on users.current_invoice= invoices.id inner join plans on invoices.plan_id= plans.id where users.id=%s',[s_id])
    Data=cursor.fetchall()


    return render_template('transactions.html' , plans = Data)

#user view profile
@app.route('/profile' , methods = ['GET', 'POST'])
def profile():
    s_id=str(session['id'])
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("select * from users where id=%s",[s_id])
    data=cursor.fetchone()
    if request.method == "POST":
        s_id= str(session['id'])
        fName  = request.form['fName']
        lName=request.form['lName']
        email = request.form['email']
        cur = mysql.connection.cursor()
        cur.execute("update users set firstname=%s,lastname=%s,email=%s where id=%s",(fName,lName,email,s_id))
        mysql.connection.commit()
        flash ('Form sent successfully!' , "info" )
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("select * from users where id=%s",[s_id])
        data=cursor.fetchone()
        return render_template('edit_user.html',data=data)


    return render_template('edit_user.html',data=data)

#contact page
@app.route('/contact' , methods = ['GET', 'POST'])
def contact():


    return render_template('contact.html')

@app.route('/about' , methods = ['GET', 'POST'])
def about():


    return render_template('about.html')


@app.route('/browse')
def script ():

    options = Options()
    options.add_argument("--headless")
    options.add_argument("--disable-gpu")
    options.add_argument("--no-sandbox")
    options.add_argument("enable-automation")
    options.add_argument("--disable-infobars")
    options.add_argument("--disable-dev-shm-usage")
    driver = webdriver.Chrome(options=options)
    driver.get("https://www.google.com/")
    element_text = driver.page_source
    driver.quit()
    return element_text



# @app.errorhandler(404)
# def page_not_found(e):
#     # note that we set the 404 status explicitly
#     return render_template('404.html'), 404
#
#
# @app.errorhandler(500)
# def page_not_found(e):
#     return render_template('404.html'), 404


@app.route("/payment")
def buy_page():
    return render_template('payment.html')


@app.route("/paypal_ipn", methods=['POST', 'GET'])
def paypal_ipn_listener():
    print("IPN event received.")

    # Sending message as-is with the notify-validate request
    params = request.form.to_dict()
    params['cmd'] = '_notify-validate'
    headers = {'content-type': 'application/x-www-form-urlencoded',
               'user-agent': 'Paypal-devdungeon-tester'}
    response = requests.post(VERIFY_URL, params=params, headers=headers, verify=True)
    response.raise_for_status()

    # See if PayPal confirms the validity of the IPN received
    if response.text == 'VERIFIED':
        print("Verified IPN response received.")
        try:
            user_id_of_buyer = params['custom'].split(":")[1]
            print("User who bought item: " + str(user_id_of_buyer))

            # Take action, e.g. update database to give user 1000 tokens

        except Exception as e:
            print(e)

    elif response.text == 'INVALID':
        # Don't trust
        print("Invalid IPN response.")
    else:
        print("Some other response.")
        print(response.text)
    return ""


@app.route("/paypal_cancel")
def paypal_cancel():
    return "PayPal cancel"


@app.route("/paypal_success")
def paypal_success():
    return "Paypal success"


@app.route("/admin/testimonial" , methods = ['POST' , 'GET'])
def testimonial_view():

    if 'loggedin' in session:

        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("SELECT * from testimonials")
        data = cursor.fetchall()
        return render_template("testimonial_admin.html" , data = data)

    return render_template("testimonial_admin.html")

@app.route('/admin/testimonial/add' , methods = ['POST' , 'GET'])
def testimonial_admin_add():

    if request.method == "POST":


        name  = request.form['name']
        description = request.form['description']
        designation = request.form['designation']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("INSERT INTO testimonials set name=%s, description = %s, designation = %s",(name,description, designation))
        mysql.connection.commit()
        flash("Testimonial Added Successfully")

        return redirect(url_for('testimonial_view'))


@app.route("/admin/testimonial/delete/<id>" , methods = ['POST' , 'GET'])
def testimonial_delete(id):

    if 'loggedin' in session:

        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("DELETE FROM testimonials WHERE id = %s",[id])
        data = cursor.fetchone()
        mysql.connection.commit()
        flash("Testimonial Deleted Successfully")

        return redirect(url_for('testimonial_view'))




@app.route('/admin/testimonial/edit/', methods = ['GET', 'POST'])
def testimonial_edit():

    if request.method == 'POST':

        name  = request.form['name']
        description = request.form['description']
        designation = request.form['designation']
        id = request.form['id']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("UPDATE testimonials set  name=%s, description=%s , designation=%s WHERE id =%s" ,(name, description , designation , id))
        mysql.connection.commit()
        flash("Testimonial Updated Successfully")
        return redirect(url_for('testimonial_view'))


# search query pass




if __name__ == "__main__":
    app.run()
    app.debug = True
