--1) Creation of DB and schema 
create database Dev_DB;
create schema banking_schema;


--2) seeing Meta data of database and schema 
select * from information_schema.databases; 

--Returns metadata about databases, that are visible to your current role(right now its Account Admin) in the Snowflake account,regardless of the current compute warehouse. 

select * from information_schema.schemata; 

--Returns metadata about schemas,that are visible to your current role(right now its Account Admin) in the Snowflake account,regardless of the current compute warehouse.

--3) Types of DB in snowflake 

--Default DB
    --1) SNOWFLAKE_LEARNING_DB : A database provided by Snowflake with tutorials, labs, and learning        resources for hands-on practice.

    --2) SNOWFLAKE_SAMPLE_DATA: A read-only database containing sample datasets for learning,               testing, and demonstrations.
    
    --3) USER$KRANTHI777: Your personal user database, automatically created by Snowflake and                   associated with your user account. It is commonly used to store worksheets, notebooks,              temporary development objects, and other personal work.
    --4) SNOWFLAKE: database is mainly used by Snowflake administrators, data engineers,and                     governance teams.

-- User DB/Company /ORGANIZATION DBs

Dev_DB
Testing_DB
Prod_DB

OR

Dev_DB  (Prod_Environment )
    bronze (data processing layers)
    silver (data processing layers)
    gold   (data processing layers)
    
Testing_DB  (Prod_Environment )
    bronze (data processing layers)
    silver (data processing layers)
    gold   (data processing layers)
    
 Prod_Dev   (Prod_Environment )
    bronze (data processing layers)
    silver (data processing layers)
    gold   (data processing layers)



--4) 
SELECT CURRENT_ROLE();  
SELECT CURRENT_WAREHOUSE();

SELECT * FROM INFORMATION_SCHEMA.DATABASES;
SELECT * FROM INFORMATION_SCHEMA.SCHEMAS;  --INVALID
SELECT * FROM INFORMATION_SCHEMA.SCHEMATA;  --INVALID
SELECT * FROM INFORMATION_SCHEMA.TABLES;

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE ='BASE TABLE';  --D1 tables
SELECT * FROM CHANNEL; --D1 tables

-- 4) Checking /running DB.schema.table in anouther db.scheme.table with below


--this table is there in RAW.stripe as well Dev_Db.banking_Schema

CREATE TABLE T1(
ID INT
);
INSERT INTO T1 VALUES(1);
SELECT * FROM T1

SELECT * FROM DEV_DB.BANKING_SCHEMA.T1;
SELECT * FROM RAW.STRIPE.T1;


--5) 
SHOW USERS;
-- Ram is the team leader
CREATE USER RAM
PASSWORD= 'temp@123';

create role analyst;
show roles;

SHOW USERS;

--The default role(when new role created) of the USER is public;

--6) Managaer asks to check RAM have what kind of user, role and etc etc 
Login from another snowflake account called : RAM, loggedin with ram id and pw
