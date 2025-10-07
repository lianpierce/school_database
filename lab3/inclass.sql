-- part A
-- task a1
INSERT INTO prodcuts(product_name, category, price, quantity, ID)
VALUES("Wireless Mouse", "Electronics", 25.99, 50, 3)

-- task a2
INSERT INTO prodcuts(company_name, email, status)
VALUES(
    company_name: "Electronics",
    email: "tech@supplies.com"
    status BOOLEAN: true,
),
(
    company_name: "Office Direct",
    email: "info@officedirect.com"
    status BOOLEAN: true,
)

-- task a3
INSERT INTO prodcuts (product_name, category, quantity, ID)
VALUES(
    product_name: "USB Cable",
    category: "Accessories",
    quantity INT: 100,
    ID: 
)
UPDATE prodcuts SET price = price * 1.2 -- 20%


-- PART B
UPDATE prodcuts SET price = price * 1.15 -- 15%
UPDATE prodcuts SET price = CASE
    WHEN quantity > 100 SET category = "Overstock"
    WHEN quantity BETWEEN 20 AND 100 SET category = "Regular"
    ELSE: category "Low Stock"
END

UPDATE prodcuts SET price CASE:
    WHEN price < 10 SET price = price * 1.5 AND SET quantity = quantity + 20
END


-- PART C
DELETE FROM prodcuts WHERE quantity = 0 AND price >50
