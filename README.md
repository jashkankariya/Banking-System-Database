# Banking System Database
### DBMS Project | NMIMS MPSTME | AY 2025-26

**Course:** Database Management Systems  
**Program:** MBA Tech AI | Semester IV  
**Submission Date:** 10/04/2026

***

## Team Members

| Roll No. | Name | Contribution |
|----------|------|--------------|
| R015 | Naitik Gokharu | Database Design, ER Diagram, Relational Model, Normalization |
| R027 | Jash Kankariya | Schema Implementation, Data Population, SQL Queries |
| R039 | Netray Nahar | Frontend Development, Flask Backend, Project Report |

***

## Project Overview

This project implements a relational database for a banking system called **National Prosperity Bank**, operating across 10 branches in Mumbai, Delhi, and Pune. The system manages customers, accounts, transactions, loans, cards, branches, and employees through a fully connected web application with a Flask backend and MySQL database.

***

## System Architecture

The project follows a **3-Tier Architecture**:

```
Browser (index.html)
       ↓  HTTP Request (fetch)
Flask API (app.py)  →  port 5000
       ↓  SQL Query
MySQL Database (banking_db)  →  port 3306
```

| Layer | Technology |
|-------|-----------|
| Frontend (Presentation) | HTML5, CSS3, Vanilla JavaScript |
| Backend (Application) | Python 3.x, Flask, flask-cors |
| Database (Data) | MySQL, mysql-connector-python |

***

## Files in this Repository

| File | Description |
|------|-------------|
| `R015,R027,R039 Banking Schema.sql` | DDL — creates all 9 tables with constraints |
| `R015,R027,R039 Banking Data.sql` | DML — inserts sample data (10+ rows per table) |
| `R015,R027,R039 Banking Queries.sql` | 22 SQL queries covering all concepts |
| `R015,R027,R039 Banking Frontend` | Frontend GUI (HTML/CSS/JS single-page app) |
| `R015,R027,R039 Banking Backend Connector.py` | Flask backend — all API routes |
| `R015,R027,R039 Banking ER Diagram.png` | Entity-Relationship Diagram |
| `R015,R027,R039 Banking Relational Schema.png` | Relational Schema Diagram |
| `R015,R027,R039 Banking Report.docx` | Full project report |
| `README.md` | This file |

***

## Database Schema

The database `banking_db` contains 9 normalized tables:

- **BANK** — Parent banking organizations
- **BRANCH** — Bank branches across cities (FK → BANK)
- **EMPLOYEE** — Staff assigned to branches (FK → BRANCH)
- **CUSTOMER** — Registered customers with KYC status
- **ACCOUNT** — Savings, Current, FD, and RD accounts (FK → CUSTOMER, BRANCH)
- **TRANSACTION** — All financial transactions with reference numbers (FK → ACCOUNT)
- **CARD** — Debit and credit cards linked to accounts (FK → ACCOUNT)
- **LOAN** — Home, Personal, Auto, Education, Business loans (FK → CUSTOMER, BRANCH)
- **LOAN_PAYMENT** — EMI payment records per loan (FK → LOAN)

***

## How to Run

### Step 1 — Set Up the Database

1. Open **MySQL Workbench**
2. Run this first:
```sql
CREATE DATABASE banking_db;
```
3. Run `Banking Schema.sql` to create all 9 tables
4. Run `Banking Data.sql` to populate sample data

### Step 2 — Install Python Dependencies

```bash
pip install flask flask-cors mysql-connector-python
```

### Step 3 — Start the Flask Backend

Navigate into the project folder and run:
```bash
python "R015,R027,R039 Banking Backend Connector.py"
```
Flask server starts at: `http://127.0.0.1:5000`  
> Keep this terminal open while using the app.

### Step 4 — Open the Frontend

Double-click `R015,R027,R039 Banking Frontend` in your browser.  
The app is now live and fetching data from MySQL. ✅

***

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/dashboard` | KPI counts + 5 recent transactions |
| GET | `/api/customers` | All customers |
| POST | `/api/customers` | Add a new customer |
| GET | `/api/accounts` | All accounts with customer & branch info |
| POST | `/api/accounts` | Open a new account |
| GET | `/api/transactions` | All transactions (filter by `?type=`) |
| POST | `/api/transactions` | Record a new transaction |
| GET | `/api/loans` | All loans with customer details |
| GET | `/api/cards` | All cards with masked numbers |
| GET | `/api/branches` | All branches with bank name |
| GET | `/api/employees` | All employees with branch details |

***

## SQL Concepts Covered (22 Queries)

- `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`
- `GROUP BY`, `HAVING`
- Aggregate functions — `COUNT`, `SUM`, `AVG`, `MAX`, `MIN`
- `INNER JOIN`, `LEFT JOIN` (multi-table)
- Subquery, Correlated Subquery, `EXISTS`
- `CASE` statement
- `UNION ALL`
- String functions — `CONCAT`, `RIGHT`
- Date functions — `TIMESTAMPDIFF`, `DATE_SUB`
- `UPDATE` with subquery
- `CREATE VIEW`
- `CREATE INDEX`
- `START TRANSACTION` / `COMMIT`
- Mathematical functions — `POW` (EMI formula)

***

## Normalization

All 9 tables satisfy **1NF, 2NF, 3NF, and BCNF**:

| Normal Form | Status | Reason |
|-------------|--------|--------|
| 1NF | ✅ Satisfied | All columns hold atomic values, each row is unique |
| 2NF | ✅ Satisfied | All PKs are single-column surrogate keys — no partial dependency |
| 3NF | ✅ Satisfied | No transitive dependencies — related data separated into own tables |
| BCNF | ✅ Satisfied | Every determinant is a candidate key |

***

## Tech Stack

| Component | Technology |
|-----------|-----------|
| Database | MySQL 8.0+ |
| Query Tool | MySQL Workbench |
| Backend | Python 3.x, Flask |
| Frontend | HTML5, CSS3, JavaScript |
| DB Connector | mysql-connector-python |
| Editor | VS Code |

***

## License

MIT License — see `LICENSE` for details.
