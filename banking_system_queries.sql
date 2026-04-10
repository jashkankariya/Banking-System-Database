-- ============================================================
-- BANKING SYSTEM - SQL QUERIES (20+ covering all concepts)
-- ============================================================

-- Q1: Basic SELECT - List all customers with their KYC status
USE banking_db;
SELECT customer_id, CONCAT(first_name,' ',last_name) AS full_name,
       email, phone, kyc_status
FROM CUSTOMER
ORDER BY first_name ASC;

-- Q2: WHERE clause - Find all Active accounts with balance > 100,000
SELECT a.account_number, CONCAT(c.first_name,' ',c.last_name) AS customer,
       a.account_type, a.balance
FROM ACCOUNT a
JOIN CUSTOMER c ON a.customer_id = c.customer_id
WHERE a.balance > 100000 AND a.status = 'Active'
ORDER BY a.balance DESC;

-- Q3: AGGREGATE - Total balance by account type
SELECT account_type,
       COUNT(*) AS total_accounts,
       SUM(balance) AS total_balance,
       ROUND(AVG(balance),2) AS avg_balance,
       MAX(balance) AS max_balance,
       MIN(balance) AS min_balance
FROM ACCOUNT
GROUP BY account_type;

-- Q4: HAVING - Branches with total loan disbursement > 1 crore
SELECT b.branch_name, b.city, COUNT(l.loan_id) AS loans_given,
       SUM(l.principal) AS total_disbursed
FROM BRANCH b
JOIN LOAN l ON b.branch_id = l.branch_id
GROUP BY b.branch_id, b.branch_name, b.city
HAVING SUM(l.principal) > 1000000
ORDER BY total_disbursed DESC;

-- Q5: INNER JOIN - Customer with their account and branch details
SELECT c.customer_id, CONCAT(c.first_name,' ',c.last_name) AS customer_name,
       a.account_number, a.account_type, b.branch_name, b.city
FROM CUSTOMER c
INNER JOIN ACCOUNT a ON c.customer_id = a.customer_id
INNER JOIN BRANCH b ON a.branch_id = b.branch_id;

-- Q6: LEFT JOIN - Customers who may or may not have a loan
SELECT CONCAT(c.first_name,' ',c.last_name) AS customer_name,
       c.email, l.loan_type, l.principal, l.status AS loan_status
FROM CUSTOMER c
LEFT JOIN LOAN l ON c.customer_id = l.customer_id
ORDER BY c.customer_id;

-- Q7: Subquery - Customers with above-average account balance
SELECT CONCAT(c.first_name,' ',c.last_name) AS customer_name,
       a.account_type, a.balance
FROM CUSTOMER c
JOIN ACCOUNT a ON c.customer_id = a.customer_id
WHERE a.balance > (SELECT AVG(balance) FROM ACCOUNT)
ORDER BY a.balance DESC;

-- Q8: Correlated Subquery - Employees earning above their branch's average salary
SELECT e.emp_id, CONCAT(e.first_name,' ',e.last_name) AS emp_name,
       e.role, e.salary, b.branch_name
FROM EMPLOYEE e
JOIN BRANCH b ON e.branch_id = b.branch_id
WHERE e.salary > (
    SELECT AVG(e2.salary) FROM EMPLOYEE e2
    WHERE e2.branch_id = e.branch_id
);

-- Q9: GROUP BY with JOIN - Transaction summary per account
SELECT a.account_number, CONCAT(c.first_name,' ',c.last_name) AS customer,
       t.txn_type, COUNT(*) AS txn_count, SUM(t.amount) AS total_amount
FROM TRANSACTION t
JOIN ACCOUNT a ON t.account_id = a.account_id
JOIN CUSTOMER c ON a.customer_id = c.customer_id
GROUP BY a.account_number, c.first_name, c.last_name, t.txn_type
ORDER BY total_amount DESC;

-- Q10: ORDER BY with LIMIT - Top 5 highest salary employees
SELECT CONCAT(first_name,' ',last_name) AS emp_name, role, salary
FROM EMPLOYEE
ORDER BY salary DESC
LIMIT 5;

-- Q11: DATE functions - Customers who opened accounts in the last 3 years
SELECT CONCAT(c.first_name,' ',c.last_name) AS customer,
       a.account_number, a.account_type, a.open_date,
       TIMESTAMPDIFF(MONTH, a.open_date, CURDATE()) AS months_since_opening
FROM ACCOUNT a
JOIN CUSTOMER c ON a.customer_id = c.customer_id
WHERE a.open_date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR);

-- Q12: CASE statement - Categorise customers by balance
SELECT CONCAT(c.first_name,' ',c.last_name) AS customer,
       a.account_number, a.balance,
       CASE
           WHEN a.balance >= 400000 THEN 'Premium'
           WHEN a.balance >= 100000 THEN 'Standard'
           WHEN a.balance >= 25000  THEN 'Basic'
           ELSE                          'Low Balance'
       END AS customer_category
FROM CUSTOMER c
JOIN ACCOUNT a ON c.customer_id = a.customer_id
ORDER BY a.balance DESC;

-- Q13: String functions - Format card numbers for display (masked)
SELECT CONCAT(c.first_name,' ',c.last_name) AS customer,
       cd.card_type,
       CONCAT('XXXX-XXXX-XXXX-', RIGHT(cd.card_number,4)) AS masked_card,
       cd.expiry_date, cd.status
FROM CARD cd
JOIN ACCOUNT a ON cd.account_id = a.account_id
JOIN CUSTOMER c ON a.customer_id = c.customer_id;

-- Q14: UPDATE - Mark accounts inactive where no transaction in 1+ year
SET SQL_SAFE_UPDATES = 0;

UPDATE ACCOUNT SET status = 'Dormant'
WHERE account_id NOT IN (
    SELECT DISTINCT account_id FROM TRANSACTION
    WHERE txn_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
)
AND status = 'Active';

SET SQL_SAFE_UPDATES = 1;
-- Q15: DELETE - Remove closed loans that were fully repaid (demonstration)
-- (Using a soft version to protect data)
SELECT loan_id, loan_type, principal, status
FROM LOAN
WHERE status = 'Closed';

-- Q16: VIEW - Create a view for customer loan summary
CREATE OR REPLACE VIEW customer_loan_summary AS
SELECT c.customer_id,
       CONCAT(c.first_name,' ',c.last_name) AS customer_name,
       COUNT(l.loan_id) AS total_loans,
       SUM(l.principal) AS total_borrowed,
       SUM(CASE WHEN l.status='Active' THEN l.principal ELSE 0 END) AS active_loan_amt
FROM CUSTOMER c
LEFT JOIN LOAN l ON c.customer_id = l.customer_id
GROUP BY c.customer_id, customer_name;

SELECT * FROM customer_loan_summary;

-- Q17: INDEX - Create index for faster transaction queries
CREATE INDEX idx_txn_date ON TRANSACTION(txn_date);
CREATE INDEX idx_account_customer ON ACCOUNT(customer_id);

-- Q18: TRANSACTION control - Safe fund transfer
START TRANSACTION;
UPDATE ACCOUNT SET balance = balance - 10000 WHERE account_id = 1;
UPDATE ACCOUNT SET balance = balance + 10000 WHERE account_id = 2;
INSERT INTO TRANSACTION (account_id, txn_type, amount, txn_date, description, reference_no)
VALUES (1, 'Transfer', 10000, CURDATE(), 'Fund Transfer to Acc 2', 'TXN_TRANSFER_001');
COMMIT;

-- Q19: Nested subquery with EXISTS - Customers who have both account and loan

SELECT customer_id, CONCAT(first_name,' ',last_name) AS customer_name, email
FROM CUSTOMER C
WHERE EXISTS (SELECT 1 FROM ACCOUNT WHERE customer_id = C.customer_id)
AND EXISTS (SELECT 1 FROM LOAN WHERE customer_id = C.customer_id);


-- Q20: UNION - Combined list of all financial obligations (loans + FD accounts)
SELECT 'Loan' AS type,
       CONCAT(c.first_name,' ',c.last_name) AS holder,
       l.principal AS amount, l.disburse_date AS start_date, l.status
FROM LOAN l JOIN CUSTOMER c ON l.customer_id = c.customer_id
UNION ALL
SELECT 'Fixed Deposit' AS type,
       CONCAT(c.first_name,' ',c.last_name) AS holder,
       a.balance AS amount, a.open_date AS start_date, a.status
FROM ACCOUNT a JOIN CUSTOMER c ON a.customer_id = c.customer_id
WHERE a.account_type = 'Fixed Deposit';

-- Q21: EMI Calculator using formula - Monthly EMI for each loan
-- EMI = P * r * (1+r)^n / ((1+r)^n - 1) where r = monthly interest rate
SELECT loan_id, loan_type, principal, interest_rate, tenure_months,
       ROUND(
           principal *
           (interest_rate/100/12) *
           POW(1 + interest_rate/100/12, tenure_months) /
           (POW(1 + interest_rate/100/12, tenure_months) - 1),
       2) AS monthly_emi
FROM LOAN
WHERE status = 'Active';

-- Q22: Multi-table JOIN - Full dashboard view for a customer (customer_id = 1)
SELECT c.customer_id, CONCAT(c.first_name,' ',c.last_name) AS name,
       a.account_number, a.account_type, a.balance, a.status AS acc_status,
       cd.card_type, cd.status AS card_status,
       l.loan_type, l.principal, l.interest_rate
FROM CUSTOMER c
LEFT JOIN ACCOUNT a ON c.customer_id = a.customer_id
LEFT JOIN CARD cd ON a.account_id = cd.account_id
LEFT JOIN LOAN l ON c.customer_id = l.customer_id
WHERE c.customer_id = 1;

