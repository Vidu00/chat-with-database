-- Banking Database Schema
-- Drop database if exists and create new one
DROP DATABASE IF EXISTS BankingDB;
CREATE DATABASE BankingDB;
USE BankingDB;

-- Table: Customers
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    date_of_birth DATE,
    address VARCHAR(200),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: Accounts
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    account_number VARCHAR(20) UNIQUE NOT NULL,
    account_type ENUM('Savings', 'Checking', 'Credit', 'Investment') NOT NULL,
    balance DECIMAL(15, 2) DEFAULT 0.00,
    interest_rate DECIMAL(5, 2) DEFAULT 0.00,
    status ENUM('Active', 'Inactive', 'Closed') DEFAULT 'Active',
    opened_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Table: Transactions
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    transaction_type ENUM('Deposit', 'Withdrawal', 'Transfer', 'Payment', 'Interest') NOT NULL,
    amount DECIMAL(15, 2) NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description VARCHAR(200),
    balance_after DECIMAL(15, 2),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

-- Table: Loans
CREATE TABLE Loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    loan_type ENUM('Personal', 'Home', 'Auto', 'Business') NOT NULL,
    loan_amount DECIMAL(15, 2) NOT NULL,
    interest_rate DECIMAL(5, 2) NOT NULL,
    term_months INT NOT NULL,
    monthly_payment DECIMAL(10, 2) NOT NULL,
    outstanding_balance DECIMAL(15, 2) NOT NULL,
    start_date DATE NOT NULL,
    status ENUM('Active', 'Paid', 'Defaulted') DEFAULT 'Active',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Table: Branches
CREATE TABLE Branches (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_name VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    phone VARCHAR(20),
    manager_name VARCHAR(100)
);

-- Table: Employees
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_id INT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    position VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    hire_date DATE,
    salary DECIMAL(10, 2),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);

-- Table: Cards
CREATE TABLE Cards (
    card_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    card_number VARCHAR(16) UNIQUE NOT NULL,
    card_type ENUM('Debit', 'Credit') NOT NULL,
    expiry_date DATE NOT NULL,
    cvv VARCHAR(3),
    credit_limit DECIMAL(15, 2),
    status ENUM('Active', 'Blocked', 'Expired') DEFAULT 'Active',
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

-- Insert Sample Data

-- Customers
INSERT INTO Customers (first_name, last_name, email, phone, date_of_birth, address, city, state, zip_code) VALUES
('John', 'Smith', 'john.smith@email.com', '555-0101', '1985-03-15', '123 Main St', 'New York', 'NY', '10001'),
('Sarah', 'Johnson', 'sarah.j@email.com', '555-0102', '1990-07-22', '456 Oak Ave', 'Los Angeles', 'CA', '90001'),
('Michael', 'Williams', 'michael.w@email.com', '555-0103', '1978-11-30', '789 Pine Rd', 'Chicago', 'IL', '60601'),
('Emily', 'Brown', 'emily.b@email.com', '555-0104', '1995-05-18', '321 Elm St', 'Houston', 'TX', '77001'),
('David', 'Jones', 'david.j@email.com', '555-0105', '1982-09-25', '654 Maple Dr', 'Phoenix', 'AZ', '85001'),
('Jessica', 'Garcia', 'jessica.g@email.com', '555-0106', '1988-12-10', '987 Cedar Ln', 'Philadelphia', 'PA', '19019'),
('Robert', 'Martinez', 'robert.m@email.com', '555-0107', '1975-04-08', '147 Birch Way', 'San Antonio', 'TX', '78201'),
('Lisa', 'Rodriguez', 'lisa.r@email.com', '555-0108', '1992-08-14', '258 Spruce Ct', 'San Diego', 'CA', '92101'),
('James', 'Wilson', 'james.w@email.com', '555-0109', '1980-01-20', '369 Willow Ave', 'Dallas', 'TX', '75201'),
('Maria', 'Anderson', 'maria.a@email.com', '555-0110', '1987-06-05', '741 Ash Blvd', 'San Jose', 'CA', '95101');

-- Branches
INSERT INTO Branches (branch_name, address, city, state, zip_code, phone, manager_name) VALUES
('Main Street Branch', '100 Main St', 'New York', 'NY', '10001', '555-1001', 'Thomas Anderson'),
('Downtown Branch', '200 Center Ave', 'Los Angeles', 'CA', '90001', '555-1002', 'Jennifer White'),
('Westside Branch', '300 West Blvd', 'Chicago', 'IL', '60601', '555-1003', 'Christopher Lee'),
('Eastside Branch', '400 East St', 'Houston', 'TX', '77001', '555-1004', 'Amanda Clark'),
('North Branch', '500 North Rd', 'Phoenix', 'AZ', '85001', '555-1005', 'Daniel Harris');

-- Employees
INSERT INTO Employees (branch_id, first_name, last_name, position, email, phone, hire_date, salary) VALUES
(1, 'Thomas', 'Anderson', 'Branch Manager', 'thomas.a@bank.com', '555-2001', '2015-01-15', 85000.00),
(1, 'Rachel', 'Green', 'Loan Officer', 'rachel.g@bank.com', '555-2002', '2018-03-20', 55000.00),
(2, 'Jennifer', 'White', 'Branch Manager', 'jennifer.w@bank.com', '555-2003', '2014-06-10', 87000.00),
(2, 'Ross', 'Geller', 'Customer Service Rep', 'ross.g@bank.com', '555-2004', '2019-08-15', 42000.00),
(3, 'Christopher', 'Lee', 'Branch Manager', 'chris.l@bank.com', '555-2005', '2016-02-28', 84000.00),
(3, 'Monica', 'Bing', 'Teller', 'monica.b@bank.com', '555-2006', '2020-01-10', 38000.00),
(4, 'Amanda', 'Clark', 'Branch Manager', 'amanda.c@bank.com', '555-2007', '2013-11-05', 88000.00),
(4, 'Chandler', 'Tribbiani', 'Financial Advisor', 'chandler.t@bank.com', '555-2008', '2017-09-22', 62000.00),
(5, 'Daniel', 'Harris', 'Branch Manager', 'daniel.h@bank.com', '555-2009', '2015-07-18', 86000.00),
(5, 'Phoebe', 'Buffay', 'Teller', 'phoebe.b@bank.com', '555-2010', '2021-04-12', 39000.00);

-- Accounts
INSERT INTO Accounts (customer_id, account_number, account_type, balance, interest_rate, status, opened_date) VALUES
(1, 'ACC1001001', 'Checking', 5240.50, 0.01, 'Active', '2020-01-15'),
(1, 'ACC1001002', 'Savings', 15000.00, 2.50, 'Active', '2020-01-15'),
(2, 'ACC1002001', 'Checking', 8750.25, 0.01, 'Active', '2019-05-20'),
(2, 'ACC1002002', 'Savings', 25000.00, 2.50, 'Active', '2019-05-20'),
(3, 'ACC1003001', 'Checking', 3200.75, 0.01, 'Active', '2021-03-10'),
(3, 'ACC1003002', 'Investment', 50000.00, 4.00, 'Active', '2021-03-10'),
(4, 'ACC1004001', 'Checking', 12500.00, 0.01, 'Active', '2022-07-05'),
(5, 'ACC1005001', 'Savings', 18000.00, 2.50, 'Active', '2020-11-18'),
(6, 'ACC1006001', 'Checking', 6800.40, 0.01, 'Active', '2021-09-22'),
(7, 'ACC1007001', 'Checking', 4500.00, 0.01, 'Active', '2019-12-15'),
(7, 'ACC1007002', 'Savings', 32000.00, 2.50, 'Active', '2019-12-15'),
(8, 'ACC1008001', 'Investment', 75000.00, 4.00, 'Active', '2020-04-30'),
(9, 'ACC1009001', 'Checking', 9200.80, 0.01, 'Active', '2022-01-20'),
(10, 'ACC1010001', 'Savings', 22000.00, 2.50, 'Active', '2021-06-12');

-- Transactions
INSERT INTO Transactions (account_id, transaction_type, amount, transaction_date, description, balance_after) VALUES
(1, 'Deposit', 1000.00, '2024-11-01 10:30:00', 'Salary deposit', 5240.50),
(1, 'Withdrawal', 200.00, '2024-11-05 14:20:00', 'ATM withdrawal', 5040.50),
(1, 'Payment', 150.00, '2024-11-10 09:15:00', 'Utility bill payment', 4890.50),
(2, 'Deposit', 2000.00, '2024-11-02 11:00:00', 'Transfer from checking', 15000.00),
(2, 'Interest', 31.25, '2024-11-15 00:00:00', 'Monthly interest', 15031.25),
(3, 'Deposit', 3500.00, '2024-11-01 09:45:00', 'Salary deposit', 8750.25),
(3, 'Withdrawal', 500.00, '2024-11-08 16:30:00', 'Cash withdrawal', 8250.25),
(4, 'Deposit', 1500.00, '2024-11-03 10:20:00', 'Savings deposit', 25000.00),
(5, 'Deposit', 800.00, '2024-11-04 13:10:00', 'Check deposit', 3200.75),
(6, 'Deposit', 5000.00, '2024-11-06 11:30:00', 'Investment return', 50000.00),
(7, 'Deposit', 4200.00, '2024-11-01 08:00:00', 'Salary deposit', 12500.00),
(7, 'Payment', 250.00, '2024-11-12 15:45:00', 'Credit card payment', 12250.00),
(8, 'Deposit', 3000.00, '2024-11-07 10:00:00', 'Monthly savings', 18000.00),
(9, 'Withdrawal', 300.00, '2024-11-09 12:20:00', 'ATM withdrawal', 6800.40),
(10, 'Deposit', 2500.00, '2024-11-11 09:30:00', 'Salary deposit', 4500.00);

-- Loans
INSERT INTO Loans (customer_id, loan_type, loan_amount, interest_rate, term_months, monthly_payment, outstanding_balance, start_date, status) VALUES
(1, 'Auto', 25000.00, 4.50, 60, 466.08, 18500.00, '2022-06-01', 'Active'),
(2, 'Home', 250000.00, 3.75, 360, 1157.79, 235000.00, '2020-03-15', 'Active'),
(3, 'Personal', 15000.00, 7.25, 36, 465.93, 8200.00, '2023-01-10', 'Active'),
(4, 'Auto', 30000.00, 4.75, 72, 467.04, 28500.00, '2024-05-20', 'Active'),
(5, 'Business', 100000.00, 5.50, 120, 1083.75, 85000.00, '2021-08-01', 'Active'),
(6, 'Home', 180000.00, 3.50, 360, 808.28, 175000.00, '2019-11-30', 'Active'),
(7, 'Personal', 10000.00, 6.99, 24, 448.56, 4500.00, '2023-09-15', 'Active'),
(8, 'Auto', 22000.00, 4.25, 60, 409.47, 15000.00, '2022-12-01', 'Active'),
(9, 'Home', 320000.00, 3.85, 360, 1499.45, 310000.00, '2023-04-10', 'Active'),
(10, 'Business', 75000.00, 5.75, 84, 1076.48, 62000.00, '2022-02-28', 'Active');

-- Cards
INSERT INTO Cards (account_id, card_number, card_type, expiry_date, cvv, credit_limit, status) VALUES
(1, '4532123456789012', 'Debit', '2026-12-31', '123', NULL, 'Active'),
(2, '4532234567890123', 'Debit', '2027-06-30', '234', NULL, 'Active'),
(3, '5412345678901234', 'Credit', '2026-09-30', '345', 10000.00, 'Active'),
(4, '5423456789012345', 'Credit', '2027-03-31', '456', 15000.00, 'Active'),
(5, '4532345678901234', 'Debit', '2026-11-30', '567', NULL, 'Active'),
(6, '5434567890123456', 'Credit', '2027-08-31', '678', 20000.00, 'Active'),
(7, '4532456789012345', 'Debit', '2026-10-31', '789', NULL, 'Active'),
(8, '4532567890123456', 'Debit', '2027-05-31', '890', NULL, 'Active'),
(9, '5445678901234567', 'Credit', '2026-12-31', '901', 12000.00, 'Active'),
(10, '4532678901234567', 'Debit', '2027-07-31', '012', NULL, 'Active');

-- Create some indexes for better query performance
CREATE INDEX idx_customer_email ON Customers(email);
CREATE INDEX idx_account_customer ON Accounts(customer_id);
CREATE INDEX idx_transaction_account ON Transactions(account_id);
CREATE INDEX idx_transaction_date ON Transactions(transaction_date);
CREATE INDEX idx_loan_customer ON Loans(customer_id);
CREATE INDEX idx_card_account ON Cards(account_id);

-- Display summary
SELECT 'Database BankingDB created successfully!' AS Status;
SELECT COUNT(*) AS Total_Customers FROM Customers;
SELECT COUNT(*) AS Total_Accounts FROM Accounts;
SELECT COUNT(*) AS Total_Transactions FROM Transactions;
SELECT COUNT(*) AS Total_Loans FROM Loans;
SELECT COUNT(*) AS Total_Branches FROM Branches;
SELECT COUNT(*) AS Total_Employees FROM Employees;
SELECT COUNT(*) AS Total_Cards FROM Cards;