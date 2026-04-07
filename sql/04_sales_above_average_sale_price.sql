SELECT 
    SaleID,
    AVG(SalePrice) AS Avg_SalePrice
FROM Sale
GROUP BY SaleID
HAVING AVG(SalePrice) > (
    SELECT AVG(SalePrice)
    FROM Sale
)
ORDER BY Avg_SalePrice DESC
FETCH FIRST 10 ROWS ONLY;
