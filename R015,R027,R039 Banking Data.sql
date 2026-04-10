-- ============================================================
-- BANKING SYSTEM - SAMPLE DATA POPULATION
-- At least 10 tuples per relation
-- ============================================================

-- BANK
INSERT INTO BANK (bank_name, headquarters, established, swift_code) VALUES
('Naitik Financial Bank', 'Bhilwara', 2006, 'NPBKINBB'),
('Jash Fincorp', 'Ahmedabad', 2006, 'ITBKINBB'),
('Netray Cooperative Bank', 'Chittor', 2006, 'SRCKINIS');

-- BRANCH
INSERT INTO BRANCH (bank_id, branch_name, city, state, ifsc_code) VALUES
(1, 'Andheri Main Branch', 'Mumbai', 'Maharashtra', 'NPB0001001'),
(1, 'Bandra West Branch',  'Mumbai', 'Maharashtra', 'NPB0001002'),
(1, 'Connaught Place Branch','Delhi','Delhi',        'NPB0001003'),
(2, 'Karol Bagh Branch',   'Delhi',  'Delhi',        'ITB0002001'),
(2, 'Lajpat Nagar Branch', 'Delhi',  'Delhi',        'ITB0002002'),
(2, 'Aundh Branch',        'Pune',   'Maharashtra',  'ITB0002003'),
(3, 'FC Road Branch',      'Pune',   'Maharashtra',  'SRC0003001'),
(3, 'Wakad Branch',        'Pune',   'Maharashtra',  'SRC0003002'),
(3, 'Viman Nagar Branch',  'Pune',   'Maharashtra',  'SRC0003003'),
(1, 'Powai Branch',        'Mumbai', 'Maharashtra',  'NPB0001004');

-- EMPLOYEE
INSERT INTO EMPLOYEE (branch_id, first_name, last_name, role, salary, hire_date) VALUES
(1, 'Jaineel',   'Shah',   'Branch Manager',    85000, '2015-06-01'),
(1, 'Yuvraj',    'Parekh',    'Loan Officer',       52000, '2018-03-15'),
(2, 'Dhanya',   'Hariya',    'Branch Manager',    80000, '2013-09-10'),
(3, 'Aditya',   'Angane',    'Cashier',            38000, '2020-01-20'),
(4, 'Aditya',   'Upadhyay',    'Branch Manager',    78000, '2016-07-05'),
(5, 'Aditya',    'Jain',    'Relationship Mgr',  55000, '2019-11-11'),
(6, 'Manya',   'Doda',    'Loan Officer',       50000, '2021-04-01'),
(7, 'Mahika',  'Kodnani',      'Branch Manager',    76000, '2014-08-22'),
(8, 'Yatarth',   'Singh',     'IT Officer',         60000, '2017-02-28'),
(9, 'Ashwini',   'Moharil',    'Cashier',            36000, '2022-06-15'),
(10,'Sambhav',   'Khandelwal',    'Branch Manager',    82000, '2012-03-30'),
(2, 'Jiya',    'Shah',    'Cashier',            37500, '2020-09-01');

-- CUSTOMER
INSERT INTO CUSTOMER (first_name, last_name, dob, email, phone, address, pan_number, kyc_status) VALUES
('Naitik',   'Gokharu', '2001-05-14', 'naitik.gokharu@email.com',  '9876543210', '12 MG Road, Mumbai',      'ABCPG1234N', 'Verified'),
('Jash',     'Kankariya','2001-08-22','jash.kankariya@email.com',   '9765432100', '45 Park St, Mumbai',      'BCDPK5678J', 'Verified'),
('Netray',   'Nahar',   '2001-11-30', 'netray.nahar@email.com',    '9654321000', '78 Hill Ave, Mumbai',     'CDEPN9012N', 'Verified'),
('Parv',    'Sharma',  '1988-03-10', 'parv.sharma@gmail.com',    '9543210000', '23 Nehru Nagar, Delhi',   'DEFPS3456P', 'Verified'),
('Jiah',     'Kothari','1975-07-25', 'jiah.kothari@yahoo.com',   '9432100000', '56 SB Road, Pune',        'EFGPK7890A', 'Verified'),
('Nirvan',    'Chhajed',   '1995-12-05', 'nirvan.chhajed@email.com',     '9321000000', '90 FC Road, Pune',        'FGHPP2345S', 'Pending'),
('Hitarth',    'Vasa',   '1983-06-18', 'hitarth.vasa@hotmail.com',   '9210000000', '34 Lajpat Rd, Delhi',     'GHIPV6789R', 'Verified'),
('Priyanshu',    'Purohit',   '1991-09-30', 'priyanshu.purohit@email.com',     '9109000000', '67 Bandra, Mumbai',       'HIJPD1234A', 'Verified'),
('Manas',   'Patil',   '1979-02-14', 'manas.patil@email.com',    '9098000000', '89 Aundh, Pune',          'IJKPR5678S', 'Verified'),
('Vikhyat',   'Yedia',    '1987-11-20', 'vikhyat.yedia@email.com',     '9087000000', '12 Powai, Mumbai',        'JKLPN9012K', 'Pending'),
('Aryesh',     'Pathak',    '1993-04-08', 'aryesh.pathak@email.com',       '9076000000', '45 Wakad, Pune',          'KLMPI3456A', 'Verified'),
('Varun',    'Agarwal',   '1982-08-15', 'varun.agarwal@email.com',     '9065000000', '78 Connaught Pl, Delhi',  'LMNPJ7890M', 'Verified');

-- ACCOUNT
INSERT INTO ACCOUNT (customer_id, branch_id, account_number, account_type, balance, open_date, status) VALUES
(1,  1, '1001000100010001', 'Savings',         125000.00, '2020-01-15', 'Active'),
(2,  2, '1001000200020002', 'Savings',          89500.50, '2019-06-20', 'Active'),
(3,  1, '1001000300030003', 'Current',         310000.00, '2021-03-10', 'Active'),
(4,  3, '1001000400040004', 'Savings',          52000.75, '2018-11-01', 'Active'),
(5,  6, '1001000500050005', 'Fixed Deposit',   500000.00, '2022-07-15', 'Active'),
(6,  7, '1001000600060006', 'Savings',          18000.00, '2023-01-05', 'Active'),
(7,  4, '1001000700070007', 'Current',         450000.00, '2017-09-12', 'Active'),
(8,  2, '1001000800080008', 'Savings',          76500.00, '2020-04-22', 'Active'),
(9,  6, '1001000900090009', 'Recurring Deposit',25000.00, '2021-12-01', 'Active'),
(10, 10,'1001001000100010', 'Savings',          33000.00, '2019-08-30', 'Dormant'),
(11, 8, '1001001100110011', 'Savings',          95000.00, '2022-02-14', 'Active'),
(12, 3, '1001001200120012', 'Current',         220000.00, '2016-05-25', 'Active'),
(1,  1, '1001001300130013', 'Fixed Deposit',   200000.00, '2023-06-01', 'Active');

-- TRANSACTION
INSERT INTO TRANSACTION (account_id, txn_type, amount, txn_date, description, reference_no) VALUES
(1, 'Deposit',    50000.00, '2024-01-10 10:30:00', 'Salary Credit',       'TXN2024010001'),
(1, 'Withdrawal', 15000.00, '2024-01-15 14:20:00', 'ATM Withdrawal',      'TXN2024010002'),
(2, 'Deposit',    30000.00, '2024-01-12 09:00:00', 'NEFT Transfer In',    'TXN2024010003'),
(3, 'Transfer',   20000.00, '2024-01-20 11:45:00', 'Vendor Payment',      'TXN2024010004'),
(4, 'Deposit',    10000.00, '2024-02-01 08:30:00', 'Cash Deposit',        'TXN2024020001'),
(5, 'Interest Credit',5000.00,'2024-02-28 00:00:00','FD Interest',        'TXN2024020002'),
(6, 'Deposit',     8000.00, '2024-02-10 12:00:00', 'UPI Transfer',        'TXN2024020003'),
(7, 'Withdrawal', 50000.00, '2024-02-15 15:30:00', 'Cheque Payment',      'TXN2024020004'),
(8, 'Deposit',    25000.00, '2024-03-05 10:00:00', 'Salary Credit',       'TXN2024030001'),
(9, 'Deposit',     5000.00, '2024-03-01 00:00:00', 'Monthly RD Installment','TXN2024030002'),
(10,'Withdrawal',  2000.00, '2023-06-10 13:00:00', 'Last Activity',       'TXN2023060001'),
(11,'Deposit',    40000.00, '2024-03-12 09:30:00', 'RTGS Transfer',       'TXN2024030003'),
(12,'Transfer',   15000.00, '2024-03-18 16:00:00', 'Supplier Payment',    'TXN2024030004'),
(1, 'EMI Payment',12000.00, '2024-04-01 00:00:00', 'Home Loan EMI',       'TXN2024040001'),
(2, 'Withdrawal', 10000.00, '2024-04-05 11:00:00', 'Online Shopping',     'TXN2024040002'),
(3, 'Deposit',    60000.00, '2024-04-10 09:00:00', 'Business Receipt',    'TXN2024040003'),
(4, 'Transfer',    5000.00, '2024-04-15 14:00:00', 'Utility Bill',        'TXN2024040004'),
(5, 'Interest Credit',6250.00,'2024-05-28 00:00:00','FD Interest Q2',     'TXN2024050001'),
(8, 'Withdrawal', 18000.00, '2024-05-02 10:30:00', 'Rent Payment',        'TXN2024050002'),
(11,'Deposit',    20000.00, '2024-05-15 12:00:00', 'Bonus Credit',        'TXN2024050003');

-- CARD
INSERT INTO CARD (account_id, card_number, card_type, expiry_date, credit_limit, status) VALUES
(1,  '4111111111111001', 'Debit',  '2027-12-31', 0.00,      'Active'),
(2,  '4111111111112002', 'Debit',  '2026-06-30', 0.00,      'Active'),
(3,  '5500000000003003', 'Credit', '2027-03-31', 100000.00, 'Active'),
(4,  '4111111111114004', 'Debit',  '2025-11-30', 0.00,      'Expired'),
(5,  '5500000000005005', 'Credit', '2028-01-31', 200000.00, 'Active'),
(7,  '5500000000007007', 'Credit', '2027-09-30', 150000.00, 'Active'),
(8,  '4111111111118008', 'Debit',  '2026-08-31', 0.00,      'Active'),
(11, '4111111111119009', 'Debit',  '2028-05-31', 0.00,      'Active'),
(12, '5500000000009010', 'Credit', '2027-06-30', 250000.00, 'Active'),
(6,  '4111111111116011', 'Debit',  '2026-01-31', 0.00,      'Active'),
(1,  '5500000000001012', 'Credit', '2028-12-31', 75000.00,  'Active');

-- LOAN
INSERT INTO LOAN (customer_id, branch_id, loan_type, principal, interest_rate, tenure_months, disburse_date, status) VALUES
(1,  1, 'Home',      2500000.00, 8.50, 240, '2021-06-01', 'Active'),
(3,  1, 'Personal',   500000.00, 12.00, 60,  '2022-09-15', 'Active'),
(5,  6, 'Auto',       800000.00, 9.75, 60,   '2023-01-20', 'Active'),
(7,  4, 'Business',  1500000.00, 10.50, 84,  '2020-03-10', 'Active'),
(4,  3, 'Education',  400000.00, 7.00, 120,  '2019-07-01', 'Active'),
(9,  6, 'Home',      1800000.00, 8.75, 180,  '2022-04-15', 'Active'),
(11, 8, 'Personal',   300000.00, 13.00, 48,  '2023-08-01', 'Active'),
(12, 3, 'Auto',       600000.00, 9.25, 72,   '2021-11-05', 'Active'),
(2,  2, 'Education',  250000.00, 6.50, 84,   '2020-08-20', 'Closed'),
(8,  2, 'Personal',   150000.00, 14.00, 24,  '2022-02-01', 'Closed');

-- LOAN_PAYMENT
INSERT INTO LOAN_PAYMENT (loan_id, payment_date, emi_amount, principal_part, interest_part) VALUES
(1, '2024-01-01', 21731.00, 4478.00, 17253.00),
(1, '2024-02-01', 21731.00, 4510.00, 17221.00),
(1, '2024-03-01', 21731.00, 4542.00, 17189.00),
(2, '2024-01-15', 11122.00, 6122.00,  5000.00),
(2, '2024-02-15', 11122.00, 6183.00,  4939.00),
(3, '2024-01-20', 16966.00,10466.00,  6500.00),
(3, '2024-02-20', 16966.00,10548.00,  6418.00),
(4, '2024-01-10', 24656.00,11906.00, 12750.00),
(5, '2024-01-01',  4647.00, 2314.00,  2333.00),
(5, '2024-02-01',  4647.00, 2327.00,  2320.00),
(6, '2024-01-15', 17968.00, 6593.00, 11375.00),
(6, '2024-02-15', 17968.00, 6641.00, 11327.00),
(7, '2024-01-01',  8048.00, 4798.00,  3250.00),
(8, '2024-01-05', 11246.00, 6621.00,  4625.00),
(8, '2024-02-05', 11246.00, 6672.00,  4574.00);

