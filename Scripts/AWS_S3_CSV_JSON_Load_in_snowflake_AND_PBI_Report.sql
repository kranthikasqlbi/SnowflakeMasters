CREATE OR REPLACE DATABASE mydatabase;

--CREATE OR REPLACE TEMPORARY TABLE mycsvtable (
-- I want to see data in powerbi, hence creating perminent table, temp table wonot appear in power bi 
CREATE OR REPLACE TABLE mycsvtable (
     id INTEGER,
     last_name STRING,
     first_name STRING,
     company STRING,
     email STRING,
     workphone STRING,
     cellphone STRING,
     streetaddress STRING,
     city STRING,
     postalcode STRING);


-- I want to see data in powerbi, hence creating perminent table, temp table wonot appear in power bi 
--CREATE OR REPLACE TEMPORARY TABLE myjsontable
CREATE OR REPLACE TABLE myjsontable (
     json_data VARIANT);

CREATE OR REPLACE WAREHOUSE mywarehouse WITH
     WAREHOUSE_SIZE='X-SMALL'
     AUTO_SUSPEND = 120
     AUTO_RESUME = TRUE
     INITIALLY_SUSPENDED=TRUE;



     CREATE OR REPLACE FILE FORMAT mycsvformat
   TYPE = 'CSV'
   FIELD_DELIMITER = '|'
   SKIP_HEADER = 1;

   CREATE OR REPLACE FILE FORMAT myjsonformat
  TYPE = 'JSON'
  STRIP_OUTER_ARRAY = TRUE;
-- STRIP..directs the COPY command to exclude the root brackets ([]) when loading data to the table.

  CREATE OR REPLACE STAGE my_csv_stage
  FILE_FORMAT = mycsvformat
  URL = 's3://snowflake-docs';


  CREATE OR REPLACE STAGE my_json_stage
  FILE_FORMAT = myjsonformat
  URL = 's3://snowflake-docs';



--creating a stage that pointed to your private data files, 

  /* 
  CREATE OR REPLACE STAGE external_stage
  FILE_FORMAT = mycsvformat
  URL = 's3://private-bucket'
  STORAGE_INTEGRATION = MYINT; 
  */

  --FOR SINGLE CSV FILE
COPY INTO mycsvtable
  FROM @my_csv_stage/tutorials/dataloading/contacts1.csv
  ON_ERROR = 'skip_file';

-- FOR MULTIPLE MATCHING CSV FILES 
  COPY INTO mycsvtable
  FROM @my_csv_stage/tutorials/dataloading/
  PATTERN='.*contacts[1-5].csv'
  ON_ERROR = 'skip_file';


  COPY INTO myjsontable
  FROM @my_json_stage/tutorials/dataloading/contacts.json
  ON_ERROR = 'skip_file';



CREATE OR REPLACE TABLE save_copy_errors AS SELECT * FROM TABLE(VALIDATE(mycsvtable, JOB_ID=>'<query_id>'));

/*VALIDATE() is a Snowflake table function used to analyze a previous COPY INTO data load and return all row-level errors (such as invalid data types, extra columns, or malformed records) by using the Query ID of that COPY INTO job. It helps identify why rows or files failed to load so the data can be corrected and reloaded.
*/


  SELECT * FROM mycsvtable;

  SELECT * FROM myjsontable;


--You need to flatten the JSON in Snowflake to see the data as charts in powerBI.

CREATE OR REPLACE VIEW MYJSON_VIEW AS
SELECT
    JSON_DATA:customer.id::STRING AS CUSTOMER_ID,
    JSON_DATA:customer.name.first::STRING AS FIRST_NAME,
    JSON_DATA:customer.name.last::STRING AS LAST_NAME,
    JSON_DATA:customer.email::STRING AS EMAIL,
    JSON_DATA:customer.phone::STRING AS PHONE,
    JSON_DATA:customer.company::STRING AS COMPANY,
    JSON_DATA:customer.address::STRING AS ADDRESS
FROM MYJSONTABLE;


DROP DATABASE IF EXISTS mydatabase;
DROP WAREHOUSE IF EXISTS mywarehouse;
