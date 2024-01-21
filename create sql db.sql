CREATE DATABASE cowlar;
USE cowlar;

CREATE TABLE customer_dataset(
	customer_id VARCHAR(10),
    customer_name VARCHAR(50),
    order_id INT,
    order_date DATE,
    shipment_date DATE,
    product_id VARCHAR(15),
    product_description VARCHAR(100),
    quantity INT,
    unit_price FLOAT
);

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\customer_dataset.csv"
INTO TABLE customer_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(customer_id, customer_name, order_id, @order_date_csv, @shipment_date_csv, product_id, product_description, quantity, @unit_price_csv)
SET order_date = STR_TO_DATE(@order_date_csv, '%d/%m/%Y'), 
shipment_date = STR_TO_DATE(@shipment_date_csv, '%d/%m/%Y'),
unit_price = REPLACE(@unit_price_csv, ',', '');