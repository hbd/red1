-- Script used for import raw, fetid, unclear CSV into PG.
CREATE SCHEMA IF NOT EXISTS import; -- New schema, to separate the fetid data from the public schema.

DROP   TABLE IF EXISTS import.master_plan;
CREATE TABLE import.master_plan (
  start_time_utc     TEXT, -- All columns are type `TEXT` initially. We will add types later.
  duration           TEXT,
  date               TEXT,
  team               TEXT,
  spass_type         TEXT,
  target             TEXT,
  request_name       TEXT,
  library_definition TEXT,
  title              TEXT,
  description        TEXT
);
COPY import.master_plan
  FROM '/root/csv/master_plan.csv' -- PG doesn't assume format, so specify which delimiter to use.
  WITH DELIMITER ','; -- HEADER CSV;

-- start_time_utc,duration,team,spass_time,target,request_name,library_definition,title,description,
