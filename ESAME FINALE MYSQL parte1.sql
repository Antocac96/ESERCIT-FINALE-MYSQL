CREATE TABLE category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);
CREATE TABLE region (
    RegionID INT PRIMARY KEY,
    RegionName VARCHAR(100) NOT NULL
);
CREATE TABLE country (
    CountryID INT PRIMARY KEY,
    CountryName VARCHAR(100) NOT NULL,
    RegionID INT NOT NULL,
    FOREIGN KEY (RegionID) REFERENCES region(RegionID)
);

CREATE TABLE product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES category(CategoryID)
);

CREATE TABLE sales (
    SalesID INT PRIMARY KEY,
    DocumentCode VARCHAR(50) NOT NULL,
    SalesDate DATE NOT NULL,
    ProductID INT NOT NULL,
    CountryID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES product(ProductID),
    FOREIGN KEY (CountryID) REFERENCES country(CountryID)
);
INSERT INTO category (CategoryID, CategoryName) VALUES
(1, 'Bikes'),
(2, 'Clothing'),
(3, 'Accessories');

INSERT INTO region (RegionID, RegionName) VALUES
(1, 'WestEurope'),
(2, 'SouthEurope'),
(3, 'NorthAmerica');

INSERT INTO country (CountryID, CountryName, RegionID) VALUES
(1, 'France', 1),
(2, 'Germany', 1),
(3, 'Italy', 2),
(4, 'Greece', 2),
(5, 'United States', 3);

INSERT INTO product (ProductID, ProductName, CategoryID) VALUES
(101, 'Bikes-100', 1),
(102, 'Bikes-200', 1),
(103, 'Bike Gloves M', 2),
(104, 'Bike Gloves L', 2),
(105, 'Helmet Pro', 3),
(106, 'Water Bottle', 3);

INSERT INTO sales (SalesID, DocumentCode, SalesDate, ProductID, CountryID, Quantity, UnitPrice) VALUES
(1, 'DOC001', '2024-01-15', 101, 1, 10, 500.00),
(2, 'DOC002', '2024-03-10', 102, 2, 8, 650.00),
(3, 'DOC003', '2024-06-05', 103, 3, 20, 25.00),
(4, 'DOC004', '2024-09-18', 105, 4, 12, 80.00),
(5, 'DOC005', '2025-02-11', 101, 3, 6, 520.00),
(6, 'DOC006', '2025-04-22', 104, 1, 15, 30.00),
(7, 'DOC007', '2025-07-09', 103, 5, 18, 27.00),
(8, 'DOC008', '2025-10-01', 105, 2, 9, 82.00);