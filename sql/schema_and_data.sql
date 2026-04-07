-- =========================
-- DROP TABLES (if exist)
-- =========================
DROP TABLE SUPPLYDETAIL;
DROP TABLE VENDOR;
DROP TABLE PART;

-- =========================
-- CREATE TABLES
-- =========================

CREATE TABLE VENDOR (
    VendorID NUMBER(5,0) PRIMARY KEY,
    VendorName VARCHAR2(50) NOT NULL,
    VendorAddress VARCHAR2(50) NOT NULL,
    City VARCHAR2(20) NOT NULL,
    State CHAR(2) NOT NULL,
    Zip NUMBER(5,0) NOT NULL
);

CREATE TABLE PART (
    PartID NUMBER(5,0) PRIMARY KEY,
    Description VARCHAR2(100) NOT NULL
);

CREATE TABLE SUPPLYDETAIL (
    PartID NUMBER(5,0),
    VendorID NUMBER(5,0),
    UnitCost NUMBER(5,0) NOT NULL,
    PRIMARY KEY (PartID, VendorID),
    FOREIGN KEY (PartID) REFERENCES PART(PartID),
    FOREIGN KEY (VendorID) REFERENCES VENDOR(VendorID)
);

-- =========================
-- INSERT DATA
-- =========================

-- Vendors
INSERT INTO VENDOR VALUES (2001, 'Fast Chip', '111 14th St', 'Cupertino', 'CA', 95015);
INSERT INTO VENDOR VALUES (2002, 'Smart Chip', '2465 Silicon Dr', 'Phoenix', 'AZ', 85001);
INSERT INTO VENDOR VALUES (2003, 'Quality Chip', '49 Tejas Blvd', 'Austin', 'TX', 73301);
INSERT INTO VENDOR VALUES (2004, 'Xtreme Chip', '1421 Fifth St', 'Davis', 'CA', 95616);

-- Parts
INSERT INTO PART VALUES (1234, 'Logic Chip');
INSERT INTO PART VALUES (5678, 'Memory Chip');

-- Supply Details
INSERT INTO SUPPLYDETAIL VALUES (1234, 2002, 8);
INSERT INTO SUPPLYDETAIL VALUES (1234, 2004, 8);
INSERT INTO SUPPLYDETAIL VALUES (5678, 2001, 3);
INSERT INTO SUPPLYDETAIL VALUES (5678, 2002, 5);
INSERT INTO SUPPLYDETAIL VALUES (5678, 2003, 2);

-- =========================
-- SAMPLE ANALYSIS QUERY
-- =========================

-- Vendors with average unit cost > $6
SELECT 
    v.VendorName,
    ROUND(AVG(s.UnitCost), 2) AS Avg_UnitCost
FROM VENDOR v
JOIN SUPPLYDETAIL s ON v.VendorID = s.VendorID
GROUP BY v.VendorName
HAVING AVG(s.UnitCost) > 6
ORDER BY Avg_UnitCost DESC;
