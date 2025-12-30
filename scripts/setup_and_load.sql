/* ==========================================================================
   HOSPITAL DATABASE SETUP & ANALYSIS SCRIPT
   Author: Selim Najaf
   Date: 2025
   ========================================================================== */

-- --------------------------------------------------------------------------
-- 1. DATABASE INITIALIZATION
-- --------------------------------------------------------------------------

DROP DATABASE IF EXISTS hospital_db;
CREATE DATABASE hospital_db;
USE hospital_db;

SET GLOBAL local_infile = 1;


-- --------------------------------------------------------------------------
-- 2. TABLE CREATION & DATA LOADING
-- --------------------------------------------------------------------------

-- Table: Payers
CREATE TABLE IF NOT EXISTS payers (
    Id                  CHAR(36) PRIMARY KEY,
    NAME                VARCHAR(100),
    ADDRESS             VARCHAR(255),
    CITY                VARCHAR(100),
    STATE_HEADQUARTERED CHAR(2),
    ZIP                 VARCHAR(10),
    PHONE               VARCHAR(20)
);

TRUNCATE TABLE payers;

LOAD DATA LOCAL INFILE '/Users/selim/Desktop/Projects/All In One/Hospital+Patient+Records/payers.csv'
INTO TABLE payers
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Table: Patients
CREATE TABLE IF NOT EXISTS patients (
    Id          CHAR(36) PRIMARY KEY,
    BIRTHDATE   DATE,
    DEATHDATE   DATE,
    PREFIX      VARCHAR(10),
    FIRST       VARCHAR(100),
    LAST        VARCHAR(100),
    SUFFIX      VARCHAR(10),
    MAIDEN      VARCHAR(100),
    MARITAL     CHAR(1),
    RACE        VARCHAR(50),
    ETHNICITY   VARCHAR(50),
    GENDER      CHAR(1),
    BIRTHPLACE  VARCHAR(255),
    ADDRESS     VARCHAR(255),
    CITY        VARCHAR(100),
    STATE       VARCHAR(100),
    COUNTY      VARCHAR(100),
    ZIP         VARCHAR(10),
    LAT         DOUBLE,
    LON         DOUBLE
);

TRUNCATE TABLE patients;

LOAD DATA LOCAL INFILE '/Users/selim/Desktop/Projects/All In One/Hospital+Patient+Records/patients.csv'
INTO TABLE patients
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Table: Procedures
CREATE TABLE procedures (
    START               TIMESTAMP,
    STOP                TIMESTAMP,
    PATIENT             CHAR(36),
    ENCOUNTER           CHAR(36),
    CODE                VARCHAR(20),
    DESCRIPTION         VARCHAR(255),
    BASE_COST           INT,
    REASONCODE          VARCHAR(20),
    REASONDESCRIPTION   VARCHAR(255)
);

TRUNCATE TABLE procedures;

LOAD DATA LOCAL INFILE '/Users/selim/Desktop/Projects/All In One/Hospital+Patient+Records/procedures.csv'
INTO TABLE procedures
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Table: Encounters
CREATE TABLE encounters (
    Id                  CHAR(36) PRIMARY KEY,
    START               DATETIME NOT NULL,
    STOP                DATETIME NOT NULL,
    PATIENT             CHAR(36) NOT NULL,
    ORGANIZATION        CHAR(36) NOT NULL,
    PAYER               CHAR(36) NOT NULL,
    ENCOUNTERCLASS      VARCHAR(50),
    CODE                VARCHAR(20),
    DESCRIPTION         VARCHAR(255),
    BASE_ENCOUNTER_COST DECIMAL(10,2),
    TOTAL_CLAIM_COST    DECIMAL(10,2),
    PAYER_COVERAGE      DECIMAL(10,2),
    REASONCODE          VARCHAR(20),
    REASONDESCRIPTION   VARCHAR(255)
);

TRUNCATE TABLE encounters;

LOAD DATA LOCAL INFILE '/Users/selim/Desktop/Projects/All In One/Hospital+Patient+Records/encounters.csv'
INTO TABLE encounters
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;