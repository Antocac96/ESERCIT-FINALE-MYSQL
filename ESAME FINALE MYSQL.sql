SELECT CategoryID, count(*)
FROM category
group by CategoryID
having count(*)>1;
SELECT CountryID, count(*)
FROM country
group by CountryID
having count(*)>1;
SELECT ProductID, count(*)
FROM product
group by ProductID
having count(*)>1;
SELECT RegionID, count(*)
FROM region
group by RegionID
having count(*)>1;
SELECT SalesID, count(*)
FROM sales
group by SalesID
having count(*)>1;
SELECT s.DocumentCode, s.SalesDate,p.ProductName,c.CategoryName,co.CountryName,r.RegionName,
 IF(s.SalesDate < CURDATE() - INTERVAL 180 DAY, 'True', 'False') as over180days
FROM sales AS s
JOIN product AS p ON s.ProductID = p.ProductID
JOIN category AS c ON p.CategoryID = c.CategoryID
JOIN country AS co ON s.CountryID = co.CountryID
JOIN region AS r ON co.RegionID = r.RegionID;
SELECT s.ProductID, SUM(s.Quantity) as TotalSold
FROM sales s
WHERE YEAR(s.SalesDate) = (
    SELECT MAX(YEAR(SalesDate))
    FROM sales
)
GROUP BY s.ProductID
HAVING SUM(s.Quantity) > (
    SELECT AVG(TotalSold)
    FROM (
        SELECT
            ProductID,
            SUM(Quantity) AS TotalSold
        FROM sales
        WHERE YEAR(SalesDate) = (
            SELECT MAX(YEAR(SalesDate))
            FROM sales
        )
        GROUP BY ProductID
    ) AS x);
SELECT co.CountryName, year(s.SalesDate) as Anno, SUM(s.Quantity*s.UnitPrice) as fattutot
FROM sales as s 
JOIN country as co
ON s.CountryID=co.CountryID
GROUP BY co.CountryName,Anno
ORDER BY fattutot,Anno DESC ;
SELECT c.CategoryName, SUM(s.Quantity) AS TotalSold
FROM sales as s
JOIN product as p ON s.ProductID = p.ProductID
JOIN category as c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName
ORDER BY TotalSold DESC
LIMIT 1;
SELECT p.ProductID, p.ProductName
from product as p 
LEFT JOIN sales as s 
ON p.ProductID=s.ProductID
WHERE s.ProductID IS NULL;
SELECT
    p.ProductID,
    p.ProductName
FROM product as p
WHERE NOT EXISTS 
(SELECT 1
FROM sales as s
WHERE s.ProductID = p.ProductID);
CREATE VIEW viewproductinfo AS
SELECT p.ProductID, p.ProductName, c.CategoryName
FROM product as p
JOIN category as c
ON p.CategoryID = c.CategoryID;
CREATE VIEW view_geoinfo AS
SELECT co.CountryID, co.CountryName, r.RegionName
FROM country as co
JOIN region as r
ON co.RegionID = r.RegionID;

