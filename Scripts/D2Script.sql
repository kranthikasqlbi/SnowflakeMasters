create database Dev_DB;
create schema banking_schema;



select * from information_schema.databases; 

--Returns metadata about databases, that are visible to your current role(right now its Account Admin) in the Snowflake account,regardless of the current compute warehouse. 

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





select * from information_schema.schemata; 

--Returns metadata about schemas,that are visible to your current role(right now its Account Admin) in the Snowflake account,regardless of the current compute warehouse.

SELECT CURRENT_ROLE();
SELECT CURRENT_WAREHOUSE();