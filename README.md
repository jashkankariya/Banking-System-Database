# Banking System Database
### DBMS Project | NMIMS MPSTME | AY 2025-26

**Course:** Database Management Systems
**Program:** MBA Tech AI | Semester IV
**Submission Date:** 10/04/2026

---

## Team Members

| Roll No. | Name |
|----------|------|
| R015 | Naitik Gokharu |
| R027 | Jash Kankariya |
| R039 | Netray Nahar |

---

## Project Overview

This project implements a relational database for a banking system called
**National Prosperity Bank**, operating across 10 branches in Mumbai, Delhi,
and Pune. The system manages customers, accounts, transactions, loans, cards,
branches, and employees.

---

## Files in this Repository

| File | Description |
|------|-------------|
| `banking_system_schema.sql` | DDL file — creates all 9 tables with constraints |
| `banking_system_data.sql` | DML file — inserts sample data (10+ rows per table) |
| `banking_system_queries.sql` | 22 SQL queries covering all concepts |
| `banking-system-app.html` | Frontend GUI (open in any browser) |
| `DBMS_Project_Report.pdf` | Full project report |
| `README.md` | This file |

---

## Database Schema

The database contains 9 tables:

- **BANK** : Parent banking organizations
- **BRANCH** : Bank branches across cities
- **EMPLOYEE** : Staff assigned to branches
- **CUSTOMER** : Registered customers with KYC status
- **ACCOUNT** : Savings, Current, FD, and RD accounts
- **TRANSACTION** : All financial transactions with reference numbers
- **CARD** : Debit and credit cards linked to accounts
- **LOAN** : Home, Personal, Auto, Education, Business loans
- **LOAN_PAYMENT** : EMI payment records per loan

---

## How to Run

### Step 1 — Set up the Database
1. Open **MySQL Workbench**
2. Run `banking_system_schema.sql` to create all tables
3. Run `banking_system_data.sql` to populate the data
4. Run `banking_system_queries.sql` to execute all 22 queries

### Step 2 — Run the Frontend
1. Open `banking-system-app.html` in any browser (Chrome recommended)
2. No server or installation required

---

## SQL Concepts Covered (22 Queries)

- SELECT, WHERE, ORDER BY, LIMIT
- GROUP BY, HAVING
- Aggregate functions — COUNT, SUM, AVG, MAX, MIN
- INNER JOIN, LEFT JOIN (multi-table)
- Subquery, Correlated Subquery, EXISTS
- CASE statement
- UNION ALL
- String functions — CONCAT, RIGHT
- Date functions — TIMESTAMPDIFF, DATE_SUB
- UPDATE with subquery
- CREATE VIEW
- CREATE INDEX
- START TRANSACTION / COMMIT
- Mathematical functions — POW (EMI formula)

---

## Tech Stack

- **Database:** MySQL 9.6
- **Query Tool:** MySQL Workbench 8.0
- **Frontend:** HTML5, CSS3, JavaScript (Vanilla)
- **Editor:** VS Code

---

## Normalization

All 9 tables satisfy **1NF, 2NF, 3NF, and BCNF**.
Single-column surrogate primary keys eliminate partial dependencies.
No transitive dependencies exist — related attributes are separated
into their own tables (e.g., branch details are in BRANCH, not in ACCOUNT).
