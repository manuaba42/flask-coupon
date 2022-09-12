from flask import Flask, render_template, Response, request, redirect, url_for, session, jsonify
from flaskext.mysql import MySQL
import pymysql
from flask_mail import Mail,Message
import sys
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SelectField
from wtforms.validators import InputRequired
from flask_bootstrap import Bootstrap
from functools import wraps

app = Flask(__name__)

app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'db_coupon'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
app.config['SECRET_KEY'] = '$lalsmeF083'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root@localhost/db_coupon'
app.config['SQLALCHEMY_TRACK_MODIFICATION'] = True

mysql = MySQL()
mysql.init_app(app)

db = SQLAlchemy(app)
bcrypt = Bcrypt(app)
bootstrap = Bootstrap(app)

app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 465
app.config['MAIL_USERNAME'] = 'dummiermail42@gmail.com'
app.config['MAIL_PASSWORD'] = 'tpzfmvqiobgjxoci'
app.config['MAIL_USE_TLS'] = False
app.config['MAIL_USE_SSL'] = True

mail = Mail(app)


conn = mysql.connect()
mycursor = conn.cursor(pymysql.cursors.DictCursor)


class User(db.Model) :
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(100))
    email = db.Column(db.String(100))
    password = db.Column(db.Text)


    def __init__(self,username, email, password) :
        self.username = username
        if password != '':
            self.password = bcrypt.generate_password_hash(password).decode('UTF-8')
        self.email = email

db.create_all()

# Regis
@app.route('/regis', methods=['GET', 'POST'])
def regis():
    if request.method == "POST":
        username = request.form["username"]
        email = request.form["email"]
        password = request.form["password"]
        db.session.add(User(username, email, password))
        db.session.commit()
        return redirect(url_for('login'))
    return render_template('regis.html')


# Login Class
class Login(FlaskForm):
    email = StringField('', validators=[InputRequired()], render_kw={'autofocus':True, 'placeholder':'Email'})
    password = PasswordField('', validators=[InputRequired()], render_kw={'autofocus':True, 'placeholder':'Password'})


def login_dulu(f):
    @wraps(f)
    def wrap(*args, **kwargs) :
        if 'login' in session:
            return f(*args, **kwargs)
        else:
            return redirect(url_for('login'))
    return wrap

@app.route('/login', methods=['GET', 'POST'])
def login():
    if session.get('login') == True:
        return redirect(url_for('home'))
    form = Login()
    if form.validate_on_submit():
        user = User.query.filter_by(email=form.email.data).first()
        if user:
            if bcrypt.check_password_hash(user.password, form.password.data):
                session['login'] = True
                session['id'] = user.id
                session['username'] = user.username
                session['email'] = user.email
                return redirect(url_for('index'))
        pesan = "email atau password atau level anda salah"
        return render_template("login.html", pesan=pesan, form=form)
    return render_template('login.html', form=form)


@app.route('/logout')
@login_dulu
def logout():
    session.clear()
    return redirect(url_for('index'))

# Route Home
@app.route("/")
def index():
    mycursor.execute('''SELECT * FROM product LIMIT 4''')
    data = mycursor.fetchall()
    return render_template("home.html", data=data)


# Route Product
@app.route("/product/<id>")
def product(id):
    # Get Product Data
    mycursor.execute('''SELECT * FROM product WHERE id = %s''', id)
    data = mycursor.fetchall()
    mycursor.execute('''SELECT category FROM categories
                        JOIN product_category ON product_category.`id_categories` = categories.`id`
                        WHERE id_product = %s''', id)
    dataCategory = mycursor.fetchall()


    # Get Product Offers
    mycursor.execute('''SELECT id_offer, discount_amount, discount_desc, discount_code, discount_link FROM offers
                        JOIN product_offer ON product_offer.`id_offer` = offers.`id`
                        JOIN product ON product.`id` = product_offer.`id_product`
                        WHERE product_offer.`id_product` = %s''', id)
    dataoffer = mycursor.fetchall()

    
    return render_template("product.html", data=data, dataCategory=dataCategory, dataoffer=dataoffer)


# Send Email Function
@app.route("/send-message", methods=['GET', 'POST'])
def send_msg():
    if request.method == "POST":
        email = request.form['inputEmail']
        subject = 'Product Coupon'
        msg = '''
                Hi User,

                It's a great time for shopping!
                Just use the discount code below at checkout:
                {}
                Link:
                {}
                '''.format(request.form['inputCode'], request.form['inputLink'])

        message = Message(subject, sender='dummiermail42@gmail.com', recipients=[email])
        message.body = msg
        mail.send(message)

        return redirect(url_for('index'))
    


if __name__=="__main__":
    app.run(debug=True)
