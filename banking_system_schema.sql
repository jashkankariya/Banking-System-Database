-- ============================================================
-- BANKING SYSTEM DATABASE - FIXED SCHEMA (MySQL 9.x Compatible)
-- DBMS Project AY 2025-26 | NMIMS STME
-- Members: Naitik Gokharu (R015), Jash Kankariya (R027), Netray Nahar (R039)
-- ============================================================

CREATE DATABASE IF NOT EXISTS banking_db;
USE banking_db;

-- Drop tables in reverse dependency order
DROP TABLE IF EXISTS LOAN_PAYMENT;
DROP TABLE IF EXISTS LOAN;
DROP TABLE IF EXISTS TRANSACTION;
DROP TABLE IF EXISTS CARD;
DROP TABLE IF EXISTS ACCOUNT;
DROP TABLE IF EXISTS CUSTOMER;
DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS BRANCH;
DROP TABLE IF EXISTS BANK;

-- ============================================================
-- TABLE DEFINITIONS
-- ============================================================

CREATE TABLE BANK (
    bank_id       INT PRIMARY KEY AUTO_INCREMENT,
    bank_name     VARCHAR(100) NOT NULL,
    headquarters  VARCHAR(150),
    established   YEAR,
    swift_code    VARCHAR(11) UNIQUE
);

CREATE TABLE BRANCH (
    branch_id     INT PRIMARY KEY AUTO_INCREMENT,
    bank_id       INT NOT NULL,
    branch_name   VARCHAR(100) NOT NULL,
    city          VARCHAR(80),
    state         VARCHAR(80),
    ifsc_code     VARCHAR(11) UNIQUE NOT NULL,
    FOREIGN KEY (bank_id) REFERENCES BANK(bank_id) ON DELETE CASCADE
);

CREATE TABLE EMPLOYEE (
    emp_id        INT PRIMARY KEY AUTO_INCREMENT,
    branch_id     INT NULL,
    first_name    VARCHAR(50) NOT NULL,
    last_name     VARCHAR(50) NOT NULL,
    role          VARCHAR(50),
    salary        DECIMAL(12,2),
    hire_date     DATE,
    FOREIGN KEY (branch_id) REFERENCES BRANCH(branch_id) ON DELETE SET NULL
);

CREATE TABLE CUSTOMER (
    customer_id   INT PRIMARY KEY AUTO_INCREMENT,
    first_name    VARCHAR(50) NOT NULL,
    last_name     VARCHAR(50) NOT NULL,
    dob           DATE,
    email         VARCHAR(100) UNIQUE,
    phone         VARCHAR(15),
    address       VARCHAR(200),
    pan_number    VARCHAR(10) UNIQUE,
    kyc_status    ENUM('Verified', 'Pending', 'Rejected') DEFAULT 'Pending',
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ACCOUNT (
    account_id      INT PRIMARY KEY AUTO_INCREMENT,
    customer_id     INT NOT NULL,
    branch_id       INT NOT NULL,
    account_number  VARCHAR(16) UNIQUE NOT NULL,
    account_type    ENUM('Savings', 'Current', 'Fixed Deposit', 'Recurring Deposit') NOT NULL,
    balance         DECIMAL(15,2) DEFAULT 0.00,
    open_date       DATE NOT NULL,
    status          ENUM('Active', 'Dormant', 'Closed') DEFAULT 'Active',
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (branch_id) REFERENCES BRANCH(branch_id)
);

CREATE TABLE TRANSACTION (
    txn_id          INT PRIMARY KEY AUTO_INCREMENT,
    account_id      INT NOT NULL,
    txn_type        ENUM('Deposit', 'Withdrawal', 'Transfer', 'EMI Payment', 'Interest Credit') NOT NULL,
    amount          DECIMAL(15,2) NOT NULL,
    txn_date        DATETIME DEFAULT CURRENT_TIMESTAMP,
    description     VARCHAR(255),
    reference_no    VARCHAR(20) UNIQUE,
    FOREIGN KEY (account_id) REFERENCES ACCOUNT(account_id) ON DELETE CASCADE
);

CREATE TABLE CARD (
    card_id         INT PRIMARY KEY AUTO_INCREMENT,
    account_id      INT NOT NULL,
    card_number     VARCHAR(16) UNIQUE NOT NULL,
    card_type       ENUM('Debit', 'Credit') NOT NULL,
    expiry_date     DATE NOT NULL,
    credit_limit    DECIMAL(12,2) DEFAULT 0.00,
    status          ENUM('Active', 'Blocked', 'Expired') DEFAULT 'Active',
    FOREIGN KEY (account_id) REFERENCES ACCOUNT(account_id) ON DELETE CASCADE
);

CREATE TABLE LOAN (
    loan_id         INT PRIMARY KEY AUTO_INCREMENT,
    customer_id     INT NOT NULL,
    branch_id       INT NOT NULL,
    loan_type       ENUM('Home', 'Personal', 'Auto', 'Education', 'Business') NOT NULL,
    principal       DECIMAL(15,2) NOT NULL,
    interest_rate   DECIMAL(5,2) NOT NULL,
    tenure_months   INT NOT NULL,
    disburse_date   DATE NOT NULL,
    status          ENUM('Active', 'Closed', 'NPA') DEFAULT 'Active',
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (branch_id) REFERENCES BRANCH(branch_id)
);

CREATE TABLE LOAN_PAYMENT (
    payment_id      INT PRIMARY KEY AUTO_INCREMENT,
    loan_id         INT NOT NULL,
    payment_date    DATE NOT NULL,
    emi_amount      DECIMAL(12,2) NOT NULL,
    principal_part  DECIMAL(12,2),
    interest_part   DECIMAL(12,2),
    FOREIGN KEY (loan_id) REFERENCES LOAN(loan_id) ON DELETE CASCADE
);

-- Verify all tables created
SHOW TABLES;
