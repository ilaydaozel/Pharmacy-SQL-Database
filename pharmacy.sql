DROP TABLE Pharmacy;
DROP TABLE Pharmacy_location;
DROP TABLE Pharmacy_phone;
DROP TABLE Drug;
DROP TABLE Payment;
DROP TABLE Inventory;
DROP TABLE Prescribes;
DROP TABLE Uses;
DROP TABLE Serves;
DROP TABLE Visits;
DROP TABLE Trades;
DROP TABLE Person;
DROP TABLE Doctor;
DROP TABLE Employee;
DROP TABLE Patient;
DROP TABLE Person_phone;
DROP TABLE Drug_inventory;
--Sets the language in which messages are displayed.
alter session set nls_language='ENGLISH';
--Sets the display format for date and time values, as well as the rules for interpreting ambiguous date input values.
alter session set nls_date_format='DD-MON-YYYY';

CREATE TABLE Pharmacy (
pharmacy_ID NUMBER(4) NOT NULL,
pharmacy_name VARCHAR2(255),
zip NUMBER(5),
apartment_number NUMBER(10),
street_name VARCHAR2(255),
inventory_ID NUMBER(4) NOT NULL,
CONSTRAINT inventory_ID_fk FOREIGN KEY (inventory_ID) REFERENCES Inventory(inventory_ID),
CONSTRAINT pharmacy_ID_pk PRIMARY KEY (pharmacy_ID)
);

CREATE TABLE Pharmacy_location (
zip NUMBER(5) NOT NULL,
city VARCHAR2(255),
CONSTRAINT zip_pk PRIMARY KEY (zip)
);

CREATE TABLE Pharmacy_phone (
pharmacy_ID NUMBER(4) NOT NULL,
phone_number NUMBER(11) NOT NULL,
CONSTRAINT pharmacy_phone_ID_pk PRIMARY KEY (pharmacy_ID,phone_number)
);

CREATE TABLE Drug (
drug_ID NUMBER(20) NOT NULL,
drug_mg NUMBER(10) NOT NULL,
drug_name VARCHAR2(255),
drug_form VARCHAR2(255),
drug_amount NUMBER(10),
price NUMBER(10),
expiration_date DATE,
quantity NUMBER(10),
CONSTRAINT drug_ID_pk PRIMARY KEY (drug_ID)
);

CREATE TABLE Payment (
payment_ID NUMBER(20) NOT NULL,
drug_amount NUMBER(11) NOT NULL,
payment_date DATE,
total_price NUMBER(10),
pharmacy_ID NUMBER(4) NOT NULL,
CONSTRAINT pharmacy_ID_fk FOREIGN KEY (pharmacy_ID) REFERENCES Pharmacy(pharmacy_ID),
CONSTRAINT payment_ID_pk PRIMARY KEY (payment_ID)
);

CREATE TABLE Inventory (
inventory_ID NUMBER(4) NOT NULL,
drug_ID NUMBER(4) NOT NULL,
drug_amount NUMBER(10),
last_update_date DATE,
CONSTRAINT inventory_drug_pk PRIMARY KEY (inventory_ID,drug_ID)
);

CREATE TABLE Prescribes (
drug_ID NUMBER(4) NOT NULL,
doctor_ID NUMBER(4) NOT NULL,
quantity NUMBER(10),
prescription_date DATE,
CONSTRAINT doctor_drug_pk PRIMARY KEY (doctor_ID,drug_ID)
);

CREATE TABLE Uses (
person_ID NUMBER(4) NOT NULL,
drug_ID NUMBER(4) NOT NULL,
CONSTRAINT person_drug_pk PRIMARY KEY (person_ID,drug_ID)
);

CREATE TABLE Serves (
employee_ID NUMBER(4) NOT NULL,
person_ID  NUMBER(4) NOT NULL,
CONSTRAINT serves_pk PRIMARY KEY (employee_ID,person_ID)
);

CREATE TABLE Drug_inventory (
inventory_ID NUMBER(4) NOT NULL,
drug_ID NUMBER(4) NOT NULL,
CONSTRAINT drug_inventory_pk PRIMARY KEY (inventory_ID,drug_ID)
);

CREATE TABLE Visits (
person_ID NUMBER(4) NOT NULL,
doctor_ID NUMBER(4) NOT NULL,
CONSTRAINT visits_pk PRIMARY KEY (person_ID,doctor_ID)
);

CREATE TABLE Trades (
payment_ID NUMBER(4) NOT NULL,
drug_ID NUMBER(4) NOT NULL,
CONSTRAINT trades_pk PRIMARY KEY (payment_ID,drug_ID)
);

CREATE TABLE Person (
person_ID NUMBER(4) NOT NULL,
age NUMBER(4),
sex VARCHAR2(255),
date_of_birth DATE,
first_name VARCHAR2(255),
second_name VARCHAR2(255),
last_name VARCHAR2(255),
CONSTRAINT person_ID_pk PRIMARY KEY (person_ID)
);

CREATE TABLE Doctor (
doctor_ID NUMBER(4) NOT NULL REFERENCES Person(person_ID),
speciality VARCHAR2(255),
work_place VARCHAR2(255),
CONSTRAINT doctor_ID_pk PRIMARY KEY (doctor_ID)
);

CREATE TABLE Employee (
employee_ID NUMBER(4) NOT NULL REFERENCES Person(person_ID),
employee_type VARCHAR2(255),
salary NUMBER(10),
CONSTRAINT employee_ID_pk PRIMARY KEY (employee_ID)
);

CREATE TABLE Patient (
patient_ID NUMBER(4) NOT NULL REFERENCES Person(person_ID),
insurance_info VARCHAR2(255),
CONSTRAINT patient_ID_pk PRIMARY KEY (patient_ID)
);

CREATE TABLE Person_phone (
person_phone_ID NUMBER(4) NOT NULL REFERENCES Person(person_ID),
phone_number NUMBER(11) NOT NULL,
CONSTRAINT person_phone_pk PRIMARY KEY (person_phone_ID,phone_number)
);
