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
    hours_worked_Q1 INT NOT NULL,
    hours_worked_Q2 INT NOT NULL,
    hours_worked_Q3 INT NOT NULL,
    hours_worked_Q4 INT NOT NULL,
    
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
    VALUES('bottles', '22500', '15000', '45000');

INSERT INTO Supplies(part_name, inventory_count, reorder_point, reorder_amount)
    VALUES('corks', '25000', '30000', '45000');
    
INSERT INTO Supplies(part_name, inventory_count, reorder_point, reorder_amount)
    VALUES('labels', '15000', '10000', '25000');
    
INSERT INTO Supplies(part_name, inventory_count, reorder_point, reorder_amount)
    VALUES('boxes', '12500', '8000', '10000');
    
INSERT INTO Supplies(part_name, inventory_count, reorder_point, reorder_amount)
    VALUES('vats', '250', '100', '250000');
    
INSERT INTO Supplies(part_name, inventory_count, reorder_point, reorder_amount)
    VALUES('tubes', '500', '250', '25000');

-- insert into supplier supplier

INSERT INTO supplies_suppliers_join(supplier_ID, part_ID, supplier_part_num)
    VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'),(SELECT part_ID FROM Supplies WHERE part_name = 'bottles'), '1001');
    
INSERT INTO supplies_suppliers_join(supplier_ID, part_ID, supplier_part_num)
    VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'),(SELECT part_ID FROM Supplies WHERE part_name = 'corks'), '2002');
    
INSERT INTO supplies_suppliers_join(supplier_ID, part_ID, supplier_part_num)
    VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'),(SELECT part_ID FROM Supplies WHERE part_name = 'labels'), '3003');
    
INSERT INTO supplies_suppliers_join(supplier_ID, part_ID, supplier_part_num)
    VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'),(SELECT part_ID FROM Supplies WHERE part_name = 'boxes'), '4004');
    
INSERT INTO supplies_suppliers_join(supplier_ID, part_ID, supplier_part_num)
    VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Tubular Vats'),(SELECT part_ID FROM Supplies WHERE part_name = 'vats'), '5005');
    
INSERT INTO supplies_suppliers_join(supplier_ID, part_ID, supplier_part_num)
    VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Tubular Vats'),(SELECT part_ID FROM Supplies WHERE part_name = 'tubes'), '6006');

-- insert into supply orders (month by month per supplier, minimum 36 entries)
INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Tubular Vats'), (SELECT part_ID FROM Supplies WHERE part_name = 'vats'), '250000', '2023-01-20', '100', '2024-01-10', '2024-01-10');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'bottles'), '45000', '2024-01-02', '15000', '2024-01-07', '2024-01-07');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'corks'), '45000', '2024-01-02', '30000', '2024-01-07', '2024-01-07');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'boxes'), '15000', '2024-01-08', '5000', '2024-01-15', '2024-01-15');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'labels'), '25000', '2024-01-08', '10000', '2024-01-15', '2024-01-15');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Tubular Vats'), (SELECT part_ID FROM Supplies WHERE part_name = 'tubes'), '25000', '2024-01-20', '250', '2024-01-30', '2024-01-30');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'bottles'), '45000', '2024-02-01', '15000', '2024-02-07', '2024-02-07');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'corks'), '45000', '2024-02-01', '30000', '2024-02-07', '2024-02-07');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'boxes'), '15000', '2024-02-08', '5000', '2024-02-15', '2024-02-19');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'labels'), '25000', '2024-02-08', '10000', '2024-02-15', '2024-02-19');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Tubular Vats'), (SELECT part_ID FROM Supplies WHERE part_name = 'tubes'), '25000', '2024-02-15', '250', '2024-02-25', '2024-02-28');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'bottles'), '45000', '2024-03-01', '15000', '2024-03-07', '2024-03-10');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'corks'), '45000', '2024-03-01', '30000', '2024-03-07', '2024-03-10');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'boxes'), '12500', '2024-03-09', '5000', '2024-03-15', '2024-03-16');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'labels'), '25000', '2024-03-09', '10000', '2024-03-15', '2024-03-16');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Tubular Vats'), (SELECT part_ID FROM Supplies WHERE part_name = 'tubes'), '25000', '2024-03-15', '250', '2024-03-25', '2024-03-31');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'bottles'), '45000', '2024-04-01', '15000', '2024-04-09', '2024-04-09');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'corks'), '45000', '2024-04-01', '30000', '2024-04-09', '2024-02-09');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'boxes'), '12500', '2024-04-08', '5000', '2024-04-15', '2024-04-15');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'labels'), '25000', '2024-04-08', '10000', '2024-04-15', '2024-04-15');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Tubular Vats'), (SELECT part_ID FROM Supplies WHERE part_name = 'tubes'), '25000', '2024-04-15', '250', '2024-04-25', '2024-04-29');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'bottles'), '45000', '2024-05-01', '15000', '2024-05-09', '2024-05-08');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'corks'), '45000', '2024-05-01', '30000', '2024-05-09', '2024-05-08');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'boxes'), '12500', '2024-05-06', '5000', '2024-05-13', '2024-05-15');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'labels'), '25000', '2024-05-06', '10000', '2024-05-13', '2024-05-15');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Tubular Vats'), (SELECT part_ID FROM Supplies WHERE part_name = 'tubes'), '25000', '2024-05-15', '250', '2024-05-25', '2024-05-26');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'bottles'), '45000', '2024-06-01', '15000', '2024-06-08', '2024-06-10');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'corks'), '45000', '2024-06-01', '30000', '2024-06-08', '2024-06-10');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'boxes'), '12500', '2024-06-08', '5000', '2024-06-15', '2024-06-15');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'labels'), '25000', '2024-06-08', '10000', '2024-06-15', '2024-06-15');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Tubular Vats'), (SELECT part_ID FROM Supplies WHERE part_name = 'tubes'), '25000', '2024-06-15', '250', '2024-06-25', '2024-06-30');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Tubular Vats'), (SELECT part_ID FROM Supplies WHERE part_name = 'vats'), '250000', '2024-06-25', '100', '2024-07-13', '2024-07-15');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'bottles'), '45000', '2024-07-01', '15000', '2024-07-06', '2024-07-07');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'corks'), '45000', '2024-07-01', '30000', '2024-07-06', '2024-07-07');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'boxes'), '12500', '2024-07-07', '5000', '2024-07-14', '2025-07-15');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'labels'), '25000', '2024-07-07', '10000', '2024-07-14', '2025-07-15');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'labels'), '25000', '2024-06-08', '10000', '2024-06-15', '2024-06-15');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Tubular Vats'), (SELECT part_ID FROM Supplies WHERE part_name = 'tubes'), '25000', '2024-07-15', '250', '2024-07-27', '2024-07-27');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'bottles'), '45000', '2024-08-01', '15000', '2024-08-06', '2024-08-09');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'corks'), '45000', '2024-08-01', '30000', '2024-08-06', '2024-08-09');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'boxes'), '12500', '2024-08-06', '5000', '2024-08-14', '2024-08-14');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'labels'), '25000', '2024-08-06', '10000', '2024-08-14', '2024-08-14');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Tubular Vats'), (SELECT part_ID FROM Supplies WHERE part_name = 'tubes'), '25000', '2024-08-15', '250', '2024-08-26', '2024-08-27');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'bottles'), '45000', '2024-09-01', '15000', '2024-09-06', '2024-09-07');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'corks'), '45000', '2024-09-01', '30000', '2024-09-06', '2024-09-07');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'boxes'), '12500', '2024-09-07', '5000', '2024-09-14', '2024-09-18');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'labels'), '25000', '2024-09-07', '10000', '2024-09-14', '2024-09-18');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Tubular Vats'), (SELECT part_ID FROM Supplies WHERE part_name = 'tubes'), '25000', '2024-09-15', '250', '2024-09-27', '2024-09-27');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'bottles'), '45000', '2024-10-01', '15000', '2024-10-07', '2024-10-07');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'corks'), '45000', '2024-10-01', '30000', '2024-10-07', '2024-10-07');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'boxes'), '12500', '2024-10-07', '5000', '2024-10-14', '2024-10-15');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'labels'), '25000', '2024-10-07', '10000', '2024-10-14', '2024-10-15');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Tubular Vats'), (SELECT part_ID FROM Supplies WHERE part_name = 'tubes'), '25000', '2024-10-15', '250', '2024-10-27', '2024-10-31');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'bottles'), '45000', '2024-11-02', '15000', '2024-11-07', '2024-11-11');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'corks'), '45000', '2024-11-02', '30000', '2024-11-07', '2024-10-11');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'boxes'), '12500', '2024-11-05', '5000', '2024-11-13', '2024-11-15');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'labels'), '25000', '2024-11-05', '10000', '2024-11-13', '2024-11-15');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Tubular Vats'), (SELECT part_ID FROM Supplies WHERE part_name = 'tubes'), '25000', '2024-11-15', '250', '2024-11-27', '2024-11-27');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'bottles'), '45000', '2024-12-01', '15000', '2024-12-08', '2024-12-08');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Bottled Up Co.'), (SELECT part_ID FROM Supplies WHERE part_name = 'corks'), '45000', '2024-12-01', '30000', '2024-12-08', '2024-12-08');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'boxes'), '12500', '2024-12-07', '5000', '2024-12-15', '2024-12-15');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Lightning Ships'), (SELECT part_ID FROM Supplies WHERE part_name = 'labels'), '25000', '2024-12-07', '10000', '2024-12-15', '2024-12-15');

INSERT INTO Supply_Orders(supplier_ID, part_ID, cost, order_date, qty, expected_delivery, actual_delivery) VALUES((SELECT supplier_ID FROM Suppliers WHERE supplier_name = 'Tubular Vats'), (SELECT part_ID FROM Supplies WHERE part_name = 'tubes'), '25000', '2024-12-13', '250', '2024-12-25', '2024-12-29');

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
    VALUES('Maria','Costanza','Distribution Head', (SELECT department_ID FROM departments WHERE department_name = 'Distribution'), (SELECT manager_ID FROM departments WHERE department_name = 'Distribution'), 'yes', NULL);

-- insert into worklog table
INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Stan' AND l_name = 'Bacchus'), '590', '620', '650', '620');

INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Davis' AND l_name = 'Bacchus'), '650', '620', '570', '630');

INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Janet' AND l_name = 'Collins'), '480', '480', '480', '480');
    
INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Roz' AND l_name = 'Murphy'), '300', '540', '650', '600');

INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Bob' AND l_name = 'Ulrich'), '350', '500', '620', '570');
    
INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Henry' AND l_name = 'Doyle'), '480', '480', '480', '480');
    
INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Vincent' AND l_name = 'Brewer'), '480', '480', '530', '450');
    
INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Michael' AND l_name = 'Amara'), '480', '480', '480', '480');

INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'David' AND l_name = 'Walker'), '480', '550', '480', '550');
    
INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Sandra' AND l_name = 'Roman'), '480', '480', '480', '480');
    
INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Greg' AND l_name = 'Brewer'), '480', '480', '480', '480');
    
INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Chad' AND l_name = 'Harding'), '380', '330', '530', '350');
    
INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Jamie' AND l_name = 'Foster'), '480', '480', '480', '480');
    
INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Virginia' AND l_name = 'Grant'), '480', '480', '530', '550');
    
INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Kyle' AND l_name = 'Dunst'), '480', '480', '430', '550');
    
INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Carlos' AND l_name = 'Garcia'), '480', '480', '480', '480');

INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Larissa' AND l_name = 'Santos'), '480', '480', '500', '470');
    
INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Monica' AND l_name = 'Wilkins'), '480', '480', '480', '480');
    
INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Harrold' AND l_name = 'Slater'), '480', '480', '480', '480');

INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Lois' AND l_name = 'Griffith'), '280', '300', '530', '250');
    
INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Jason' AND l_name = 'Long'), '480', '480', '480', '480');
    
INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Rose' AND l_name = 'McNeal'), '280', '380', '330', '250');
    
INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Gloria' AND l_name = 'Shane'), '500', '480', '500', '480');
    
INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Oliver' AND l_name = 'Gaines'), '500', '480', '530', '450');

INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Ralieh' AND l_name = 'Acquire'), '480', '480', '530', '450');
    
INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Caddly' AND l_name = 'Hoohoo'), '480', '480', '400', '480');
    
INSERT INTO worklog(empl_ID, hours_worked_Q1, hours_worked_Q2, hours_worked_Q3, hours_worked_Q4)
    VALUES((SELECT empl_ID FROM employees WHERE f_name = 'Maria' AND l_name = 'Costanza'), '530', '480', '530', '450');

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
    VALUES('2023-08-12', '98', (SELECT wine_ID FROM wines WHERE wine_name = 'Chardonnay'), '6530', '850', '120000');

INSERT INTO batches(batch_date, grade, wine_ID, bottles_available, total_bottles_produced, price)
    VALUES('2023-08-27', '85', (SELECT wine_ID FROM wines WHERE wine_name = 'Chablis'), '5200', '1250', '95600');
    
INSERT INTO batches(batch_date, grade, wine_ID, bottles_available, total_bottles_produced, price)
    VALUES('2023-09-22', '88', (SELECT wine_ID FROM wines WHERE wine_name = 'Merlot'), '6500', '2500', '125000');

INSERT INTO batches(batch_date, grade, wine_ID, bottles_available, total_bottles_produced, price)
    VALUES('2023-10-02', '90', (SELECT wine_ID FROM wines WHERE wine_name = 'Cabernet'), '4870', '2200', '115000');
        
INSERT INTO batches(batch_date, grade, wine_ID, bottles_available, total_bottles_produced, price)
    VALUES('2024-03-20', '85', (SELECT wine_ID FROM wines WHERE wine_name = 'Chablis'), '5200', '1250', '95600');
    
INSERT INTO batches(batch_date, grade, wine_ID, bottles_available, total_bottles_produced, price)
    VALUES('2024-03-29', '88', (SELECT wine_ID FROM wines WHERE wine_name = 'Merlot'), '6500', '2500', '125000');
    
INSERT INTO batches(batch_date, grade, wine_ID, bottles_available, total_bottles_produced, price)
    VALUES('2024-04-12', '98', (SELECT wine_ID FROM wines WHERE wine_name = 'Chardonnay'), '6530', '850', '120000');
        
INSERT INTO batches(batch_date, grade, wine_ID, bottles_available, total_bottles_produced, price)
    VALUES('2024-04-22', '90', (SELECT wine_ID FROM wines WHERE wine_name = 'Cabernet'), '4870', '2200', '115000');



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
    VALUES ('2024-01-02', (SELECT distributor_ID FROM distributor WHERE distributor_name = 'Mediator Distribution'), 'late', (SELECT batch_ID FROM batches WHERE batch_date = '2023-08-27' AND wine_ID = (SELECT wine_ID FROM wines WHERE wine_name = 'Chablis')), '4450', '2024-01-09', '2024-01-11');
    
INSERT INTO distributor_orders (order_date, distributor_ID, order_status, batch_ID, qty, expected_delivery, actual_delivery)
    VALUES ('2024-01-14', (SELECT distributor_ID FROM distributor WHERE distributor_name = 'Bottle Flip'), 'late', (SELECT batch_ID FROM batches WHERE batch_date = '2023-10-02' AND wine_ID = (SELECT wine_ID FROM wines WHERE wine_name = 'Cabernet')), '4450', '2024-01-20', '2024-01-23');
    
INSERT INTO distributor_orders (order_date, distributor_ID, order_status, batch_ID, qty, expected_delivery, actual_delivery)
    VALUES ('2024-01-16', (SELECT distributor_ID FROM distributor WHERE distributor_name = 'Sherpack Fulfilment'), 'success', (SELECT batch_ID FROM batches WHERE batch_date = '2023-09-22' AND wine_ID = (SELECT wine_ID FROM wines WHERE wine_name = 'Merlot')), '4450', '2024-01-22', '2024-01-22');

INSERT INTO distributor_orders (order_date, distributor_ID, order_status, batch_ID, qty, expected_delivery, actual_delivery)
    VALUES ('2024-02-12', (SELECT distributor_ID FROM distributor WHERE distributor_name = 'D & D Wholesale'), 'late', (SELECT batch_ID FROM batches WHERE batch_date = '2023-08-12' AND wine_ID = (SELECT wine_ID FROM wines WHERE wine_name = 'Chardonnay')), '4450', '2024-02-27', '2024-03-01');

INSERT INTO distributor_orders (order_date, distributor_ID, order_status, batch_ID, qty, expected_delivery, actual_delivery)
    VALUES ('2024-05-09', (SELECT distributor_ID FROM distributor WHERE distributor_name = 'Company Distribution'), 'success', (SELECT batch_ID FROM batches WHERE batch_date = '2024-03-29' AND wine_ID = (SELECT wine_ID FROM wines WHERE wine_name = 'Merlot')), '4450', '2024-05-22', '2024-05-22');

INSERT INTO distributor_orders (order_date, distributor_ID, order_status, batch_ID, qty, expected_delivery, actual_delivery)
    VALUES ('2024-06-12', (SELECT distributor_ID FROM distributor WHERE distributor_name = 'Mediator Distribution'), 'success', (SELECT batch_ID FROM batches WHERE batch_date = '2024-03-20' AND wine_ID = (SELECT wine_ID FROM wines WHERE wine_name = 'Chablis')), '4450', '2024-06-22', '2024-06-22');
    
INSERT INTO distributor_orders (order_date, distributor_ID, order_status, batch_ID, qty, expected_delivery, actual_delivery)
    VALUES ('2024-07-27', (SELECT distributor_ID FROM distributor WHERE distributor_name = 'Liquidation Wholesale'), 'late', (SELECT batch_ID FROM batches WHERE batch_date = '2023-04-12' AND wine_ID = (SELECT wine_ID FROM wines WHERE wine_name = 'Chardonnay')), '4450', '2024-08-03', '2024-08-07');
    
INSERT INTO distributor_orders (order_date, distributor_ID, order_status, batch_ID, qty, expected_delivery, actual_delivery)
    VALUES ('2024-09-01', (SELECT distributor_ID FROM distributor WHERE distributor_name = 'Company Distribution'), 'late', (SELECT batch_ID FROM batches WHERE batch_date = '2024-03-29' AND wine_ID = (SELECT wine_ID FROM wines WHERE wine_name = 'Merlot')), '4450', '2024-09-10', '2024-09-13');

INSERT INTO distributor_orders (order_date, distributor_ID, order_status, batch_ID, qty, expected_delivery, actual_delivery)
    VALUES ('2024-11-24', (SELECT distributor_ID FROM distributor WHERE distributor_name = 'Park Lake Distribution'), 'success', (SELECT batch_ID FROM batches WHERE batch_date = '2024-04-22' AND wine_ID = (SELECT wine_ID FROM wines WHERE wine_name = 'Cabernet')), '4450', '2024-12-05', '2024-12-05');
        

-- insert into shipments
INSERT INTO shipments(expected_delivery, actual_delivery, shipped_date, tracking_number)
    VALUES('2024-01-09', '2024-01-11', '2024-01-06', '09003374');

INSERT INTO shipments(expected_delivery, actual_delivery, shipped_date, tracking_number)
    VALUES('2024-01-22', '2024-01-22', '2024-01-15', '09003374');

INSERT INTO shipments(expected_delivery, actual_delivery, shipped_date, tracking_number)
    VALUES('2024-01-20', '2024-01-23', '2024-01-16', '09022778');
    
INSERT INTO shipments(expected_delivery, actual_delivery, shipped_date, tracking_number)
    VALUES('2024-02-27', '2024-03-01', '2024-02-21', '09993557');
    
INSERT INTO shipments(expected_delivery, actual_delivery, shipped_date, tracking_number)
    VALUES('2024-05-22', '2024-05-22', '2024-05-16', '09004571');

INSERT INTO shipments(expected_delivery, actual_delivery, shipped_date, tracking_number)
    VALUES('2024-06-22', '2024-06-22', '2024-06-17', '09094974');
    
INSERT INTO shipments(expected_delivery, actual_delivery, shipped_date, tracking_number)
    VALUES('2024-08-03', '2024-08-07', '2024-08-01', '09896977');
    
INSERT INTO shipments(expected_delivery, actual_delivery, shipped_date, tracking_number)
    VALUES('2024-09-10', '2024-09-13', '2024-09-07', '09136691');
    
INSERT INTO shipments(expected_delivery, actual_delivery, shipped_date, tracking_number)
    VALUES('2024-12-05', '2024-12-05', '2024-11-30', '09094974');
    
-- insert into shipment_order_join
INSERT INTO shipment_order_join (shipment_ID, order_ID)
    VALUES((SELECT shipment_ID FROM shipments JOIN distributor_orders ON distributor_orders.actual_delivery = shipments.actual_delivery WHERE shipments.shipped_date='2024-01-06'), (SELECT order_ID FROM distributor_orders JOIN shipments ON distributor_orders.actual_delivery = shipments.actual_delivery WHERE shipments.shipped_date='2024-01-06'));
    
INSERT INTO shipment_order_join (shipment_ID, order_ID)
    VALUES((SELECT shipment_ID FROM shipments JOIN distributor_orders ON distributor_orders.actual_delivery = shipments.actual_delivery WHERE shipments.shipped_date='2024-01-15'), (SELECT order_ID FROM distributor_orders JOIN shipments ON distributor_orders.actual_delivery = shipments.actual_delivery WHERE shipments.shipped_date='2024-01-15'));
    
INSERT INTO shipment_order_join (shipment_ID, order_ID)
    VALUES((SELECT shipment_ID FROM shipments JOIN distributor_orders ON distributor_orders.actual_delivery = shipments.actual_delivery WHERE shipments.shipped_date='2024-01-16'), (SELECT order_ID FROM distributor_orders JOIN shipments ON distributor_orders.actual_delivery = shipments.actual_delivery WHERE shipments.shipped_date='2024-01-16'));
    
INSERT INTO shipment_order_join (shipment_ID, order_ID)
    VALUES((SELECT shipment_ID FROM shipments JOIN distributor_orders ON distributor_orders.actual_delivery = shipments.actual_delivery WHERE shipments.shipped_date='2024-02-21'), (SELECT order_ID FROM distributor_orders JOIN shipments ON distributor_orders.actual_delivery = shipments.actual_delivery WHERE shipments.shipped_date='2024-02-21'));
    
INSERT INTO shipment_order_join (shipment_ID, order_ID)
    VALUES((SELECT shipment_ID FROM shipments JOIN distributor_orders ON distributor_orders.actual_delivery = shipments.actual_delivery WHERE shipments.shipped_date='2024-05-16'), (SELECT order_ID FROM distributor_orders JOIN shipments ON distributor_orders.actual_delivery = shipments.actual_delivery WHERE shipments.shipped_date='2024-05-16'));

INSERT INTO shipment_order_join (shipment_ID, order_ID)
    VALUES((SELECT shipment_ID FROM shipments JOIN distributor_orders ON distributor_orders.actual_delivery = shipments.actual_delivery WHERE shipments.shipped_date='2024-06-17'), (SELECT order_ID FROM distributor_orders JOIN shipments ON distributor_orders.actual_delivery = shipments.actual_delivery WHERE shipments.shipped_date='2024-06-17'));
    
INSERT INTO shipment_order_join (shipment_ID, order_ID)
    VALUES((SELECT shipment_ID FROM shipments JOIN distributor_orders ON distributor_orders.actual_delivery = shipments.actual_delivery WHERE shipments.shipped_date='2024-08-01'), (SELECT order_ID FROM distributor_orders JOIN shipments ON distributor_orders.actual_delivery = shipments.actual_delivery WHERE shipments.shipped_date='2024-08-01'));
    
INSERT INTO shipment_order_join (shipment_ID, order_ID)
    VALUES((SELECT shipment_ID FROM shipments JOIN distributor_orders ON distributor_orders.actual_delivery = shipments.actual_delivery WHERE shipments.shipped_date='2024-09-07'), (SELECT order_ID FROM distributor_orders JOIN shipments ON distributor_orders.actual_delivery = shipments.actual_delivery WHERE shipments.shipped_date='2024-09-07'));

INSERT INTO shipment_order_join (shipment_ID, order_ID)
    VALUES((SELECT shipment_ID FROM shipments JOIN distributor_orders ON distributor_orders.actual_delivery = shipments.actual_delivery WHERE shipments.shipped_date='2024-11-30'), (SELECT order_ID FROM distributor_orders JOIN shipments ON distributor_orders.actual_delivery = shipments.actual_delivery WHERE shipments.shipped_date='2024-11-30'));