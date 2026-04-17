from flask import Flask, jsonify, request
from flask_cors import CORS
import mysql.connector

app = Flask(__name__)
CORS(app)

def get_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="root",
        database="banking_db"
    )

def query(sql, params=None):
    db = get_db()
    cur = db.cursor(dictionary=True)
    cur.execute(sql, params or ())
    result = cur.fetchall()
    cur.close()
    db.close()
    return result

def execute(sql, params=None):
    db = get_db()
    cur = db.cursor()
    cur.execute(sql, params or ())
    db.commit()
    last_id = cur.lastrowid
    cur.close()
    db.close()
    return last_id

# ── DASHBOARD ──────────────────────────────────────────────
@app.route('/api/dashboard')
def dashboard():
    return jsonify({
        'customers':    query("SELECT COUNT(*) AS c FROM CUSTOMER")[0]['c'],
        'accounts':     query("SELECT COUNT(*) AS c FROM ACCOUNT")[0]['c'],
        'transactions': query("SELECT COUNT(*) AS c FROM TRANSACTION")[0]['c'],
        'loans':        query("SELECT COUNT(*) AS c FROM LOAN WHERE status='Active'")[0]['c'],
        'branches':     query("SELECT COUNT(*) AS c FROM BRANCH")[0]['c'],
        'employees':    query("SELECT COUNT(*) AS c FROM EMPLOYEE")[0]['c'],
        'recent': query("""
            SELECT T.reference_no, A.account_number, T.txn_type,
                   T.amount, T.txn_date, T.description
            FROM TRANSACTION T
            JOIN ACCOUNT A ON T.account_id = A.account_id
            ORDER BY T.txn_date DESC, T.txn_id DESC LIMIT 5""")
    })

# ── CUSTOMERS ──────────────────────────────────────────────
@app.route('/api/customers')
def customers():
    return jsonify(query("""
        SELECT customer_id, first_name, last_name,
               CONCAT(first_name,' ',last_name) AS full_name,
               email, phone, pan_number, kyc_status
        FROM CUSTOMER ORDER BY first_name"""))

@app.route('/api/customers', methods=['POST'])
def add_customer():
    d = request.json
    id = execute("""INSERT INTO CUSTOMER
        (first_name,last_name,email,phone,pan_number,kyc_status,dob,address)
        VALUES(%s,%s,%s,%s,%s,'Pending','2000-01-01','India')""",
        (d['fname'],d['lname'],d['email'],d['phone'],d.get('pan','PENDING')))
    return jsonify({'success': True, 'id': id})

# ── ACCOUNTS ───────────────────────────────────────────────
@app.route('/api/accounts')
def accounts():
    return jsonify(query("""
        SELECT A.account_id, A.account_number, A.account_type,
               A.balance, A.open_date, A.status,
               CONCAT(C.first_name,' ',C.last_name) AS customer_name,
               B.branch_name
        FROM ACCOUNT A
        JOIN CUSTOMER C ON A.customer_id = C.customer_id
        JOIN BRANCH B ON A.branch_id = B.branch_id
        ORDER BY A.account_id"""))

@app.route('/api/accounts', methods=['POST'])
def add_account():
    d = request.json
    acc_num = '10010' + str(d['customer_id']).zfill(4) + str(d['branch_id']).zfill(4) + '001'
    execute("""INSERT INTO ACCOUNT
        (customer_id,branch_id,account_number,account_type,balance,open_date,status)
        VALUES(%s,%s,%s,%s,%s,CURDATE(),'Active')""",
        (d['customer_id'],d['branch_id'],acc_num,d['account_type'],d.get('balance',0)))
    return jsonify({'success': True})

# ── TRANSACTIONS ───────────────────────────────────────────
@app.route('/api/transactions')
def transactions():
    txn_type = request.args.get('type','')
    sql = """
        SELECT T.txn_id, T.reference_no, A.account_number,
               T.txn_type, T.amount, T.txn_date, T.description
        FROM TRANSACTION T
        JOIN ACCOUNT A ON T.account_id = A.account_id
        {where}
        ORDER BY T.txn_date DESC, T.txn_id DESC"""
    where = "WHERE T.txn_type=%s" if txn_type else ""
    params = (txn_type,) if txn_type else ()
    return jsonify(query(sql.format(where=where), params))

@app.route('/api/transactions', methods=['POST'])
def add_transaction():
    d = request.json
    import random, string
    ref = 'TXN' + ''.join(random.choices(string.digits, k=10))
    execute("""INSERT INTO TRANSACTION
        (account_id,txn_type,amount,txn_date,description,reference_no)
        VALUES(%s,%s,%s,CURDATE(),%s,%s)""",
        (d['account_id'],d['txn_type'],d['amount'],d.get('description',''),ref))
    return jsonify({'success': True, 'ref': ref})

# ── LOANS ──────────────────────────────────────────────────
@app.route('/api/loans')
def loans():
    return jsonify(query("""
        SELECT L.loan_id, L.loan_type, L.principal,
               L.interest_rate, L.tenure_months,
               L.disburse_date, L.status,
               CONCAT(C.first_name,' ',C.last_name) AS customer_name
        FROM LOAN L
        JOIN CUSTOMER C ON L.customer_id = C.customer_id
        ORDER BY L.loan_id"""))

# ── CARDS ──────────────────────────────────────────────────
@app.route('/api/cards')
def cards():
    return jsonify(query("""
        SELECT CD.card_id, CD.card_number, CD.card_type,
               CD.expiry_date, CD.credit_limit, CD.status,
               CONCAT(C.first_name,' ',C.last_name) AS customer_name
        FROM CARD CD
        JOIN ACCOUNT A ON CD.account_id = A.account_id
        JOIN CUSTOMER C ON A.customer_id = C.customer_id
        ORDER BY CD.card_id"""))

# ── BRANCHES ───────────────────────────────────────────────
@app.route('/api/branches')
def branches():
    return jsonify(query("""
        SELECT B.branch_id, B.branch_name, B.city, B.state, B.ifsc_code,
               BK.bank_name
        FROM BRANCH B JOIN BANK BK ON B.bank_id = BK.bank_id
        ORDER BY B.branch_id"""))

# ── EMPLOYEES ──────────────────────────────────────────────
@app.route('/api/employees')
def employees():
    return jsonify(query("""
        SELECT E.emp_id, CONCAT(E.first_name,' ',E.last_name) AS employee_name,
               E.role, E.salary, E.hire_date, B.branch_name
        FROM EMPLOYEE E
        JOIN BRANCH B ON E.branch_id = B.branch_id
        ORDER BY E.emp_id"""))

if __name__ == '__main__':
    app.run(debug=True, port=5000)
