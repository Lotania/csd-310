DROP DATABASE IF EXISTS Bacchus;

CREATE DATABASE Bacchus;

USE Bacchus;

-- drop database user if exists 
DROP USER IF EXISTS 'Bacchus_user'@'localhost';

CREATE USER 'Bacchus_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'BacchWine';

GRANT ALL PRIVILEGES ON Bacchus.* TO 'Bacchus_user'@'localhost';

-- drop tables if they are present
DROP TABLE IF EXISTS Suppliers;
DROP TABLE IF EXISTS Supplies;
DROP TABLE IF EXISTS Supply_orders;
DROP TABLE IF EXISTS supplies_suppliers_join;

DROP TABLE IF EXISTS worklog;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

DROP TABLE IF EXISTS shipments;
DROP TABLE IF EXISTS distributor;
DROP TABLE IF EXISTS distributor_orders;
DROP TABLE IF EXISTS wines;
DROP TABLE IF EXISTS batches;
DROP TABLE IF EXISTS shipment_order_join;

CREATE TABLE Suppliers (
    supplier_ID     INT             NOT NULL    AUTO_INCREMENT,
    supplier_name   VARCHAR(75)     NOT NULL,
    contact_name   VARCHAR(75)     NOT NULL,
    contact_email   VARCHAR(75)     NOT NULL,
    contact_phone   VARCHAR(15)     NOT NULL,
     
    PRIMARY KEY(supplier_ID)
);

CREATE TABLE Supplies (
    part_ID     INT             NOT NULL    AUTO_INCREMENT,
    part_name   VARCHAR(75)     NOT NULL,
    inventory_count   VARCHAR(75)     NOT NULL,
    reorder_point   VARCHAR(75)     NOT NULL,
    reorder_amount   VARCHAR(15)     NOT NULL,
    
    PRIMARY KEY(part_ID)
);

CREATE TABLE departments (
    department_ID     INT             NOT NULL    AUTO_INCREMENT,
    department_name   VARCHAR(75)     NOT NULL,
    manager_ID   INT    NOT NULL,
    
    PRIMARY KEY(department_ID)
);

CREATE TABLE employees (
    empl_ID   INT             NOT NULL    AUTO_INCREMENT,
    f_name  VARCHAR(35)     NOT NULL,
    l_name   VARCHAR(35)     NOT NULL,
    job_title    VARCHAR(50)    NOT NULL,
    department_ID    INT    NOT NULL,
    supervisor_ID    INT,
    is_salary   VARCHAR(5)    NOT NULL,
    hourly_pay_rate    INT,
    
    
    PRIMARY KEY(empl_ID)
);

CREATE TABLE shipments (
    shipment_ID   INT             NOT NULL    AUTO_INCREMENT,
    expected_delivery    DATE    NOT NULL,
    actual_delivery    DATE,
    shipped_date    DATE,
    tracking_number    INT,
    
    
    PRIMARY KEY(shipment_ID)
);

CREATE TABLE distributor (
    distributor_ID   INT             NOT NULL    AUTO_INCREMENT,
    distributor_name  VARCHAR(75)     NOT NULL,
    distributor_address_line1   VARCHAR(75)     NOT NULL,
    distributor_address_line2   VARCHAR(75),
    distributor_state   VARCHAR(75)     NOT NULL,
    distributor_zip    INT     NOT NULL,
    contact_name    VARCHAR(75)    NOT NULL,
    contact_number VARCHAR(15) NOT NULL,
    contact_email    VARCHAR(75)    NOT NULL,
    
    
    PRIMARY KEY(distributor_ID)
);

CREATE TABLE wines (
    wine_ID     INT             NOT NULL    AUTO_INCREMENT,
    wine_name   VARCHAR(25)     NOT NULL,
    grapes_used    VARCHAR(75)    NOT NULL,
    
    
    PRIMARY KEY(wine_ID)
);

CREATE TABLE batches (
    batch_ID    INT             NOT NULL    AUTO_INCREMENT,
    batch_date    DATE     NOT NULL,
    grade    VARCHAR(15)     NOT NULL,
    wine_ID         INT             NOT NULL,
    bottles_available    INT     NOT NULL,
    total_bottles_produced    INT    NOT NULL,
    price   INT    NOT NULL,
    
    
    PRIMARY KEY(batch_ID),
    
    CONSTRAINT fk_wines FOREIGN KEY(wine_ID) REFERENCES wines(wine_ID)
);

CREATE TABLE Supply_Orders (
    supply_order_ID     INT             NOT NULL    AUTO_INCREMENT,
    supplier_id     INT     NOT NULL,
    part_ID   INT     NOT NULL,
    cost   INT     NOT NULL,
    order_date   DATE     NOT NULL,
    qty   INT     NOT NULL,
    expected_delivery   DATE     NOT NULL,
    actual_delivery   DATE     NOT NULL,
    
    PRIMARY KEY(supply_order_ID),
    
    CONSTRAINT fk_Suppliers FOREIGN KEY(supplier_ID) REFERENCES Suppliers(supplier_ID),
    CONSTRAINT fk_Supplies FOREIGN KEY(part_ID) REFERENCES Supplies(part_ID)
);

CREATE TABLE supplies_suppliers_join (
    supplier_ID     INT     NOT NULL,
    part_ID   INT     NOT NULL,
    supplier_part_num   INT     NOT NULL,

    PRIMARY KEY(supplier_ID, part_ID),
    
    CONSTRAINT fk_Suppliers2 FOREIGN KEY(supplier_ID) REFERENCES Suppliers(supplier_ID),
    CONSTRAINT fk_Supplies2 FOREIGN KEY(part_ID) REFERENCES Supplies(part_ID)
);

CREATE TABLE worklog (
    worklog_entry_ID   INT             NOT NULL    AUTO_INCREMENT,
    empl_ID     INT    NOT NULL,
    work_date     DATE     NOT NULL,
    hours_worked INT NOT NULL,
    
    PRIMARY KEY(worklog_entry_ID),
    
    CONSTRAINT fk_employees FOREIGN KEY(empl_ID) REFERENCES employees(empl_ID)
);

CREATE TABLE distributor_orders (
    order_ID           INT NOT NULL AUTO_INCREMENT,
    order_date         DATE NOT NULL,
    distributor_ID     INT NOT NULL,
    order_status       VARCHAR(15) NOT NULL,
    batch_ID           INT NOT NULL,
    qty                INT NOT NULL,
    expected_delivery   DATE NOT NULL,
    actual_delivery    DATE,
    
    PRIMARY KEY(order_ID),
    
    CONSTRAINT fk_distributor FOREIGN KEY(distributor_ID) REFERENCES distributor(distributor_ID),
    CONSTRAINT fk_batches FOREIGN KEY(batch_ID) REFERENCES batches(batch_ID)
);

CREATE TABLE shipment_order_join (
    shipment_id   INT NOT NULL,
    order_id      INT NOT NULL,
    PRIMARY KEY(shipment_id),
    CONSTRAINT fk_distributorders FOREIGN KEY(order_id) REFERENCES distributor_orders(order_ID)
);

-- insert into suppliers records
INSERT INTO Suppliers(supplier_name, contact_name, contact_email, contact_phone)
    VALUES('Bottled Up Co.', 'John Mason', 'johnbottle@gmail.com', '9722799720');
    
INSERT INTO Suppliers(supplier_name, contact_name, contact_email, contact_phone)
    VALUES('Lightning Ships', 'Kennedy Carmichael', 'lightlab@gmail.com', '8003387464');
    
INSERT INTO Suppliers(supplier_name, contact_name, contact_email, contact_phone)
    VALUES('Tubular Vats', 'Donald Rylieh', 'donrvats@yahoo.com', '9823784903');

-- insert into supplies records
INSERT INTO Supplies(part_name, inventory_count, reorder_point, reorder_amount)
    VALUES('bottles', '12500', '1000', '30000');

INSERT INTO Supplies(part_name, inventory_count, reorder_point, reorder_amount)
    VALUES('corks', '30000', '15000', '30000');
    
INSERT INTO Supplies(part_name, inventory_count, reorder_point, reorder_amount)
    VALUES('label', '50000', '10000', '300000');
    
INSERT INTO Supplies(part_name, inventory_count, reorder_point, reorder_amount)
    VALUES('boxes', '45000', '1500', '25000');
    
INSERT INTO Supplies(part_name, inventory_count, reorder_point, reorder_amount)
    VALUES('vats', '1000', '100000', '3500');
    
INSERT INTO Supplies(part_name, inventory_count, reorder_point, reorder_amount)
    VALUES('tubes', '1000', '250', '300');
    
-- insert into supply orders
INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery)
    VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'boxes'), '7500', '2025-01-15', '2500', '2025-02-18', '2025-02-14');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery)
    VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'bottles'), '21000', '2025-01-06', '3000', '2025-01-27', '2025-02-04');
    
INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery)
    VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'corks'), '16000', '2025-01-05', '3000', '2025-01-29', '2025-01-29');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery)
    VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Tubular Vats'), (SELECT part_ID FROM Supplies WHERE part_name = 'vats'), '505000', '2025-01-05', '150', '2025-01-31', '2025-02-02');
    
INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery)
    VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'labels'), '7500', '2025-01-01', '3000', '2025-01-31', '2025-02-07');
    
INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery)
    VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'bottles'), '27500', '2024-12-05', '3500', '2025-01-05', '2025-01-14');
    
INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery)
    VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'corks'), '16000', '2024-12-05', '3000', '2025-01-09', '2025-01-19');
    
INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery)
    VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Tubular Vats'), (SELECT part_ID FROM Supplies WHERE part_name = 'tubes'), '27500', '2024-12-05', '300', '2025-01-27', '2025-02-04');
    
INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery)
    VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'bottles'), '27500', '2024-11-05', '3500', '2024-12-05', '2024-01-04');
    
INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery)
    VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Tubular Vats'), (SELECT part_ID FROM Supplies WHERE part_name = 'vats'), '505000', '2024-11-05', '6000', '2024-11-27', '2024-12-04');
    
-- insert into supplier supplier
INSERT INTO supplies_suppliers_join(supplier_ID, part_ID, supplier_part_num)
    VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'corks'), '1001');
    
INSERT INTO supplies_suppliers_join(supplier_ID, part_ID, supplier_part_num)
    VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'bottles'), '2002');
    
INSERT INTO supplies_suppliers_join(supplier_ID, part_ID, supplier_part_num)
    VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Tubular Vats'), (SELECT part_ID FROM Supplies WHERE part_name = 'tubes'), '3003');
    
INSERT INTO supplies_suppliers_join(supplier_ID, part_ID, supplier_part_num)
    VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Tubular Vats'), (SELECT part_ID FROM Supplies WHERE part_name = 'vats'), '4004');
    
INSERT INTO supplies_suppliers_join(supplier_ID, part_ID, supplier_part_num)
    VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'labels'), '5005');
    
INSERT INTO supplies_suppliers_join(supplier_ID, part_ID, supplier_part_num)
    VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'boxes'), '6006');

-- insert into departments
INSERT INTO departments(department_name, manager_ID)
    VALUES('Executive', '11');
    
INSERT INTO departments(department_name, manager_ID)
    VALUES('Payroll and Finance', '22');
    
INSERT INTO departments(department_name, manager_ID)
    VALUES('Marketing', '33');
    
INSERT INTO departments(department_name, manager_ID)
    VALUES('Production', '44');
    
INSERT INTO departments(department_name, manager_ID)
    VALUES('Distribution', '55');
    
-- insert into employees table   
INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Stan','Bacchus','co-owner', (SELECT department_ID FROM departments WHERE department_name = 'Executive'), (SELECT manager_ID FROM departments WHERE department_name = 'Executive'), 'yes', NULL);
    
INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Davis','Bacchus','co-owner', (SELECT department_ID FROM departments WHERE department_name = 'Executive'), (SELECT manager_ID FROM departments WHERE department_name = 'Executive'), 'yes', NULL);

INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Janet','Collins','P&F Manager', (SELECT department_ID FROM departments WHERE department_name = 'Payroll and Finance'), (SELECT manager_ID FROM departments WHERE department_name = 'Payroll and Finance'), 'yes', NULL);
    
INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Roz','Murphy','Marketing Head', (SELECT department_ID FROM departments WHERE department_name = 'Marketing'), (SELECT manager_ID FROM departments WHERE department_name = 'Marketing'), 'yes', NULL);

INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Bob','Ulrich','Marketing Assistant', (SELECT department_ID FROM departments WHERE department_name = 'Marketing'), NULL, 'no', '35');
    
INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Henry','Doyle','Production Manager', (SELECT department_ID FROM departments WHERE department_name = 'Production'), (SELECT manager_ID FROM departments WHERE department_name = 'Production'), 'yes', NULL);

INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Vincent','Brewer','Production Technician', (SELECT department_ID FROM departments WHERE department_name = 'Production'), NULL, 'no', '27');

INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Michael','Amara','Production Technician', (SELECT department_ID FROM departments WHERE department_name = 'Production'), NULL, 'no', '27');

INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('David','Walker','Production Technician', (SELECT department_ID FROM departments WHERE department_name = 'Production'), NULL, 'no', '25');

INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Sandra','Roman','Production Technician', (SELECT department_ID FROM departments WHERE department_name = 'Production'), NULL, 'no', '25');

INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Greg','Brewer','Production Technician', (SELECT department_ID FROM departments WHERE department_name = 'Production'), NULL, 'no', '25');

INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Chad','Harding','Production Technician', (SELECT department_ID FROM departments WHERE department_name = 'Production'), NULL, 'no', '27');
    
INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Jamie','Foster','Production Technician', (SELECT department_ID FROM departments WHERE department_name = 'Production'), NULL, 'no', '25');
    
INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Virginia','Grant','Production Technician', (SELECT department_ID FROM departments WHERE department_name = 'Production'), NULL, 'no', '24');
    
INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Kyle','Dunst','Production Technician', (SELECT department_ID FROM departments WHERE department_name = 'Production'), NULL, 'no', '24');
    
INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Carlos','Garcia','Production Technician', (SELECT department_ID FROM departments WHERE department_name = 'Production'), NULL, 'no', '24');
    
INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Larissa','Santos','Production Technician', (SELECT department_ID FROM departments WHERE department_name = 'Production'), NULL, 'no', '24');
    
INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Monica','Wilkins','Production Technician', (SELECT department_ID FROM departments WHERE department_name = 'Production'), NULL, 'no', '23');
    
INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Harrold','Slater','Production Technician', (SELECT department_ID FROM departments WHERE department_name = 'Production'), NULL, 'no', '23');
    
INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Lois','Griffith','Production Technician', (SELECT department_ID FROM departments WHERE department_name = 'Production'), NULL, 'no', '22');
        
INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Jason','Long','Production Technician', (SELECT department_ID FROM departments WHERE department_name = 'Production'), NULL, 'no', '22');
        
INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Rose','McNeal','Production Technician', (SELECT department_ID FROM departments WHERE department_name = 'Production'), NULL, 'no', '22');
        
INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Gloria','Shane','Production Technician', (SELECT department_ID FROM departments WHERE department_name = 'Production'), NULL, 'no', '22');
        
INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Oliver','Gaines','Production Technician', (SELECT department_ID FROM departments WHERE department_name = 'Production'), NULL, 'no', '21');
        
INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Ralieh','Acquire','Production Technician', (SELECT department_ID FROM departments WHERE department_name = 'Production'), NULL, 'no', '20');
        
INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Caddly','Hoohoo','Production Technician', (SELECT department_ID FROM departments WHERE department_name = 'Production'), NULL, 'no', '20');
        
INSERT INTO employees(f_name, l_name, job_title, department_ID, supervisor_ID, is_salary, hourly_pay_rate)
    VALUES('Maria','Costanza','Distribution Head', (SELECT department_ID FROM departments WHERE department_name = 'Production'), (SELECT manager_ID FROM departments WHERE department_name = 'Production'), 'yes', NULL);

-- insert into worklog table
INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Stan' AND l_name = 'Bacchus'), '2025-02-13', '12');

INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Davis' AND l_name = 'Bacchus'), '2025-02-13', '12');

INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Janet' AND l_name = 'Collins'), '2025-02-13', '11');
    
INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Roz' AND l_name = 'Murphy'), '2025-02-13', '9');

INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Bob' AND l_name = 'Ulrich'), '2025-02-13', '9');
    
INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Henry' AND l_name = 'Doyle'), '2025-02-13', '10');
    
INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Vincent' AND l_name = 'Brewer'), '2025-02-13', '8');
    
INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Michael' AND l_name = 'Amara'), '2025-02-13', '8');

INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'David' AND l_name = 'Walker'), '2025-02-13', '8');
    
INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Sandra' AND l_name = 'Roman'), '2025-02-13', '10');
    
INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Greg' AND l_name = 'Brewer'), '2025-02-13', '9');
    
INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Chad' AND l_name = 'Harding'), '2025-02-13', '8');
    
INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Jamie' AND l_name = 'Foster'), '2025-02-13', '7');
    
INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Virginia' AND l_name = 'Grant'), '2025-02-13', '8');
    
INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Kyle' AND l_name = 'Dunst'), '2025-02-13', '8');
    
INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Carlos' AND l_name = 'Garcia'), '2025-02-13', '8');

INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Larissa' AND l_name = 'Santos'), '2025-02-13', '10');
    
INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Monica' AND l_name = 'Wilkins'), '2025-02-13', '10');
    
INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Harrold' AND l_name = 'Slater'), '2025-02-13', '8');

INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Lois' AND l_name = 'Griffith'), '2025-02-13', '8');
    
INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Jason' AND l_name = 'Long'), '2025-02-13', '7');
    
INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Rose' AND l_name = 'McNeal'), '2025-02-13', '8');
    
INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Gloria' AND l_name = 'Shane'), '2025-02-13', '9');
    
INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Oliver' AND l_name = 'Gaines'), '2025-02-13', '9');

INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Ralieh' AND l_name = 'Acquire'), '2025-02-13', '8');
    
INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Caddly' AND l_name = 'Hoohoo'), '2025-02-13', '8');
    
INSERT INTO worklog(empl_ID, work_date, hours_worked)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Maria' AND l_name = 'Costanza'), '2025-02-13', '10');

-- is there no easier way to do this?!
-- insert into wines table
INSERT INTO wines(wine_name, grapes_used)
    VALUES('Merlot', 'Merlot grapes');

INSERT INTO wines(wine_name, grapes_used)
    VALUES('Cabernet', 'Cabernet Sauvignon grapes');

INSERT INTO wines(wine_name, grapes_used)
    VALUES('Chablis', 'Chardonnay grapes');

INSERT INTO wines(wine_name, grapes_used)
    VALUES('Chardonnay', 'Chardonnay grapes');
    

-- insert into batches table
INSERT INTO batches(batch_date, grade, wine_ID, bottles_available, total_bottles_produced, price)
    VALUES('2024-08-22', '88', (SELECT wine_ID FROM wines WHERE wine_name = 'Merlot'), '6500', '2500', '125000');

INSERT INTO batches(batch_date, grade, wine_ID, bottles_available, total_bottles_produced, price)
    VALUES('2024-01-12', '98', (SELECT wine_ID FROM wines WHERE wine_name = 'Chardonnay'), '6530', '850', '120000');

INSERT INTO batches(batch_date, grade, wine_ID, bottles_available, total_bottles_produced, price)
    VALUES('2024-04-20', '85', (SELECT wine_ID FROM wines WHERE wine_name = 'Chablis'), '5200', '1250', '95600');

INSERT INTO batches(batch_date, grade, wine_ID, bottles_available, total_bottles_produced, price)
    VALUES('2024-10-22', '90', (SELECT wine_ID FROM wines WHERE wine_name = 'Cabernet'), '4870', '2200', '115000');

INSERT INTO batches(batch_date, grade, wine_ID, bottles_available, total_bottles_produced, price)
    VALUES('2025-01-03', '88', (SELECT wine_ID FROM wines WHERE wine_name = 'Chardonnay'), '6870', '6030', '130000');

INSERT INTO batches(batch_date, grade, wine_ID, bottles_available, total_bottles_produced, price)
    VALUES('2025-01-22', '79', (SELECT wine_ID FROM wines WHERE wine_name = 'Chablis'), '4870', '4860', '110000');



-- insert into distributor table
INSERT INTO distributor(distributor_name, distributor_address_line1, distributor_address_line2, distributor_state, distributor_zip, contact_name, contact_number, contact_email) 
    VALUES('Mediator Distribution', '4096 Blue Valley Drive', NULL, 'Texas', '75040', 'Jonah Rockwell', '9726503783', 'jrmediator@protonmail.com');

INSERT INTO distributor(distributor_name, distributor_address_line1, distributor_address_line2, distributor_state, distributor_zip, contact_name, contact_number, contact_email) 
    VALUES('Sherpack Fulfilment', '54 Foundry Rd', NULL, 'Texas', '79007', 'Sully Seneca', '9268789000', 'ssSherpack@gmail.com');

INSERT INTO distributor(distributor_name, distributor_address_line1, distributor_address_line2, distributor_state, distributor_zip, contact_name, contact_number, contact_email) 
    VALUES('D & D Wholesale', '2770 Rocky Canyon Rd', NULL, 'Texas', '79411', 'Lilly Graves', '7075649787', 'justthegrave@gmail.com');
    
INSERT INTO distributor(distributor_name, distributor_address_line1, distributor_address_line2, distributor_state, distributor_zip, contact_name, contact_number, contact_email) 
    VALUES('Company Distribution', '4600 Array Ave', NULL, 'Texas', '79735', 'Evelynn Paisley', '2148765789', 'epay-company@protonmail.com');

INSERT INTO distributor(distributor_name, distributor_address_line1, distributor_address_line2, distributor_state, distributor_zip, contact_name, contact_number, contact_email) 
    VALUES('Lone Star Wholesale', '3901 Nokong Way', NULL, 'Texas', '77964', 'Sheila Armstrong', '9703934300', 'lssheila@outlook.com');

INSERT INTO distributor(distributor_name, distributor_address_line1, distributor_address_line2, distributor_state, distributor_zip, contact_name, contact_number, contact_email) 
    VALUES('Liquidation Wholesale', '1 Rock Worm Drive', NULL, 'Texas', '76856', 'Donna Chorld', '9726503783', 'jrmediator@protonmail.com');

INSERT INTO distributor(distributor_name, distributor_address_line1, distributor_address_line2, distributor_state, distributor_zip, contact_name, contact_number, contact_email) 
    VALUES('The Line Sales', '1026 Red Creek Rd', NULL, 'Texas', '76711', 'Zachary Tyler', '8834476518', 'zackline@protonmail.com');
    
INSERT INTO distributor(distributor_name, distributor_address_line1, distributor_address_line2, distributor_state, distributor_zip, contact_name, contact_number, contact_email) 
    VALUES('Bottle Flip', '2760 Monument Park Way', NULL, 'Oklahoma', '73084', 'Doug Blane', '3592425754', 'bottleflip@yahoo.mail.com');
    
INSERT INTO distributor(distributor_name, distributor_address_line1, distributor_address_line2, distributor_state, distributor_zip, contact_name, contact_number, contact_email) 
    VALUES('Park Lake Distribution', '700 Battery St', NULL, 'Oklahoma', '73119', 'Jim Fowler', '4973867540', 'parklakedistribution@protonmail.com');
    
-- insert into distribute orders
INSERT INTO distributor_orders (order_date, distributor_ID, order_status, batch_ID, qty, expected_delivery, actual_delivery)
    VALUES ('2024-10-12', (SELECT distributor_ID FROM distributor WHERE distributor_name = 'Sherpack Fulfilment' LIMIT 1), 
    'pending', (SELECT batch_ID FROM batches WHERE batch_date = '2024-01-12' AND wine_ID = (SELECT wine_ID FROM wines WHERE wine_name = 'Chardonnay') LIMIT 1), 450, '2024-10-25', '2024-10-25');

INSERT INTO distributor_orders (order_date, distributor_ID, order_status, batch_ID, qty, expected_delivery, actual_delivery)
    VALUES ('2024-11-02', (SELECT distributor_ID FROM distributor WHERE distributor_name = 'Liquidation Wholesale' LIMIT 1), 
    'late', (SELECT batch_ID FROM batches WHERE batch_date = '2024-04-20' AND wine_ID = (SELECT wine_ID FROM wines WHERE wine_name = 'Chablis') LIMIT 1), 500, '2024-11-12', '2024-11-20');

INSERT INTO distributor_orders (order_date, distributor_ID, order_status, batch_ID, qty, expected_delivery, actual_delivery)
    VALUES ('2024-11-29', (SELECT distributor_ID FROM distributor WHERE distributor_name = 'The Line Sales' LIMIT 1), 
    'success', (SELECT batch_ID FROM batches WHERE batch_date = '2024-10-22' AND wine_ID = (SELECT wine_ID FROM wines WHERE wine_name = 'Cabernet') LIMIT 1), 250, '2024-12-12', '2024-12-12');

INSERT INTO distributor_orders (order_date, distributor_ID, order_status, batch_ID, qty, expected_delivery, actual_delivery)
    VALUES ('2024-12-15', (SELECT distributor_ID FROM distributor WHERE distributor_name = 'Bottle Flip' LIMIT 1), 
    'success', (SELECT batch_ID FROM batches WHERE batch_date = '2024-01-12' AND wine_ID = (SELECT wine_ID FROM wines WHERE wine_name = 'Chardonnay') LIMIT 1), 250, '2024-12-17', '2024-12-19');

INSERT INTO distributor_orders (order_date, distributor_ID, order_status, batch_ID, qty, expected_delivery, actual_delivery)
    VALUES ('2025-01-25', (SELECT distributor_ID FROM distributor WHERE distributor_name = 'Park Lake Distribution' LIMIT 1), 
    'late', (SELECT batch_ID FROM batches WHERE batch_date = '2024-08-22' AND wine_ID = (SELECT wine_ID FROM wines WHERE wine_name = 'Merlot') LIMIT 1), 350, '2025-02-07','2025-02-12');

INSERT INTO distributor_orders (order_date, distributor_ID, order_status, batch_ID, qty, expected_delivery, actual_delivery)
    VALUES ('2025-02-12', (SELECT distributor_ID FROM distributor WHERE distributor_name = 'Mediator Distribution' LIMIT 1), 
    'pending', (SELECT batch_ID FROM batches WHERE batch_date = '2025-01-22' AND wine_ID = (SELECT wine_ID FROM wines WHERE wine_name = 'Chablis') LIMIT 1), 450, '2025-02-22', NULL);
    
-- insert into shipments
INSERT INTO shipments(expected_delivery, actual_delivery, shipped_date, tracking_number)
    VALUES('2024-12-17', '2024-12-19', '2024-12-13', '09003374');

INSERT INTO shipments(expected_delivery, actual_delivery, shipped_date, tracking_number)
    VALUES('2024-10-25', '2024-10-25', '2024-10-16', '09356765');

INSERT INTO shipments(expected_delivery, actual_delivery, shipped_date, tracking_number)
    VALUES('2024-11-12', '2024-11-20', '2024-11-16', '09966779');

INSERT INTO shipments(expected_delivery, actual_delivery, shipped_date, tracking_number)
    VALUES('2024-12-12', '2024-12-12', '2024-12-08', '09393938');

INSERT INTO shipments(expected_delivery, actual_delivery, shipped_date, tracking_number)
    VALUES('2025-02-07', '2025-02-12', '2025-02-05', '09987894');
    
INSERT INTO shipments(expected_delivery, actual_delivery, shipped_date, tracking_number)
    VALUES('2025-02-22', NULL, '2025-02-20', NULL);
    
-- insert into shipment_order_join
-- doesn't show/
INSERT INTO shipment_order_join(shipment_ID, order_ID)
    VALUES((SELECT shipment_ID FROM shipments JOIN distributor_orders ON shipments.expected_delivery = distributor_orders.expected_delivery WHERE shipments.shipped_date = '2024-10-16'), (SELECT order_ID FROM distributor_orders JOIN shipments ON shipments.expected_delivery = distributor_orders.expected_delivery WHERE shipments.shipped_date = '2024-10-16'));

INSERT INTO shipment_order_join(shipment_ID, order_ID)
    VALUES((SELECT shipment_ID FROM shipments JOIN distributor_orders ON shipments.expected_delivery = distributor_orders.expected_delivery WHERE shipments.shipped_date = '2024-11-16'), (SELECT order_ID FROM distributor_orders JOIN shipments ON shipments.expected_delivery = distributor_orders.expected_delivery WHERE shipments.shipped_date = '2024-11-16'));

INSERT INTO shipment_order_join(shipment_ID, order_ID)
    VALUES((SELECT shipment_ID FROM shipments JOIN distributor_orders ON shipments.expected_delivery = distributor_orders.expected_delivery WHERE shipments.shipped_date = '2024-12-08'), (SELECT order_ID FROM distributor_orders JOIN shipments ON shipments.expected_delivery = distributor_orders.expected_delivery WHERE shipments.shipped_date = '2024-12-08'));

INSERT INTO shipment_order_join(shipment_ID, order_ID)
    VALUES((SELECT shipment_ID FROM shipments JOIN distributor_orders ON shipments.expected_delivery = distributor_orders.expected_delivery WHERE shipments.shipped_date = '2024-10-13'), (SELECT order_ID FROM distributor_orders JOIN shipments ON shipments.expected_delivery = distributor_orders.expected_delivery WHERE shipments.shipped_date = '2024-12-13'));
    
INSERT INTO shipment_order_join(shipment_ID, order_ID)
    VALUES((SELECT shipment_ID FROM shipments JOIN distributor_orders ON shipments.expected_delivery = distributor_orders.expected_delivery WHERE shipments.shipped_date = '2025-02-05'), (SELECT order_ID FROM distributor_orders JOIN shipments ON shipments.expected_delivery = distributor_orders.expected_delivery WHERE shipments.shipped_date = '2025-02-05'));
    
INSERT INTO shipment_order_join(shipment_ID, order_ID)
    VALUES((SELECT shipment_ID FROM shipments JOIN distributor_orders ON shipments.expected_delivery = distributor_orders.expected_delivery WHERE shipments.shipped_date = NULL), (SELECT order_ID FROM distributor_orders JOIN shipments ON shipments.expected_delivery = distributor_orders.expected_delivery WHERE shipments.shipped_date = '2025-02-20'));