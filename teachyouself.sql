----------------------------------------------------------------------------------------
二 检索数据  
mysql> SELECT prod_name FROM Products LIMIT 5;
mysql> SELECT prod_name FROM Products LIMIT 5 OFFSET 5;
-- 这是一行注释    /**/

三 排序检索数据  ORDER BY 子句
mysql> SELECT prod_name FROM Products ORDER BY prod_name;
mysql> SELECT prod_name FROM Products ORDER BY prod_id;
mysql> SELECT prod_id,prod_price,prod_name FROM Products ORDER BY prod_price,prod_name;
mysql> SELECT prod_id,prod_price,prod_name FROM Products ORDER BY 2,3;
mysql> SELECT prod_id,prod_price,prod_name FROM Products ORDER BY prod_price DESC;
mysql> SELECT prod_id,prod_price,prod_name FROM Products ORDER BY prod_price DESC,prod_name;

四 过滤数据
mysql> SELECT prod_id,prod_price,prod_name FROM Products WHERE prod_price ！= 3.49 ;
mysql> SELECT prod_id,prod_price,prod_name FROM Products WHERE prod_pricE IS NULL;
mysql> SELECT prod_id,prod_price,prod_name FROM Products WHERE prod_price<4 AND vend_id = 'DLL01';
mysql> SELECT prod_id,prod_price,prod_name FROM Products WHERE (prod_price<4 OR vend_id = 'BRS01') AND prod_price >= 10;
mysql> SELECT prod_id,prod_price,prod_name FROM Products WHERE vend_id IN ('DLL01','BRS01');
mysql> SELECT prod_id,prod_price,prod_name FROM Products WHERE NOT vend_id = 'BRS01';

六 用通配符进行过滤
mysql> SELECT prod_id,prod_name FROM Products WHERE prod_name LIKE 'Fish%'; -- F%y%
mysql> SELECT prod_id,prod_name FROM Products WHERE prod_name LIKE '__inch teddy bear';
mysql> SELECT cust_contact FROM Customers WHERE (NOT) cust_contact LIKE '[^JM]%' ORDER BY cust_contact;

七 创建计算字段
mysql> SELECT vend_name AS vend_title FROM Vendors ORDER BY vend_name;
mysql> SELECT vend_name ,vend_country FROM Vendors ORDER BY vend_name;
mysql> SELECT prod_id,quantity,item_price,quantity*item_price AS expanded_price FROM OrderItems WHERE order_num=20008;
mysql> SELECT Now();
mysql> SELECT 2*3;
mysql> SELECT prod_id,quantity,item_price,2*(+-*/)item_price AS expanded_price FROM OrderItems WHERE order_num=20008;

八 使用数据处理函数
mysql> SELECT vend_name,UPPER(vend_name) AS vend_name_upcase FROM Vendors ORDER BY vend_name; --大写
mysql> SELECT cust_name cust_contac FROM Customers WHERE SOUNDEX(cust_contact) = SOUNDEX('Michael Green');

九 汇总数据
mysql> SELECT AVG(prod_price) AS avg_price FROM Products;
mysql> SELECT AVG(prod_price) AS avg_price FROM Products WHERE vend_id = 'DLL01';
mysql> SELECT COUNT(*) AS num_cust FROM Customers;
mysql> SELECT COUNT(cust_email) AS num_cust FROM Customers;
mysql> SELECT MAX(prod_price) AS max_price FROM Products;
mysql> SELECT MIN(prod_price) AS max_price FROM Products;
mysql> SELECT SUM(quantity) AS items_ordered FROM OrderItems WHERE order_num = 20005;
mysql> SELECT SUM(item_price*quantity) AS total_price FROM OrderItems WHERE order_num = 20005;
mysql> SELECT AVG(COUNT () )(DISTINCT prod_price) AS avg_price FROM Products WHERE vend_id = 'DLL01';
mysql> SELECT COUNT(*) AS num_items,MIN(prod_price) AS price_min,MAX(prod_price) AS price_max,AVG(prod_price) AS price_avg FROM Products;

十 分组数据
mysql> SELECT COUNT(*) AS num_prods FROM Products;
mysql> SELECT vend_id,COUNT(*) AS num_prods FROM Products;
mysql> SELECT COUNT(*) AS num_prods FROM Products WHERE vend_id = 'DLL01';
mysql> SELECT vend_id,COUNT(*) AS num_prods FROM Products GROUP BY vend_id;
过滤分组
mysql> SELECT cust_id,COUNT(*) AS orders FROM Orders GROUP BY cust_id HAVING COUNT(*) >= 2;
mysql> SELECT vend_id,COUNT(*) AS num_prods FROM Products WHERE prod_price >= 4 GROUP BY vend_id HAVING COUNT(*) >= 2;
mysql> SELECT vend_id,COUNT(*) AS num_prods FROM Products GROUP BY vend_id HAVING COUNT(*) >= 2;
mysql> SELECT order_num,COUNT(*) AS items FROM OrderItems GROUP BY order_num HAVING COUNT(*) >= 3;
mysql> SELECT order_num,COUNT(*) AS items FROM OrderItems GROUP BY order_num HAVING COUNT(*) >= 3 ORDER BY items,order_num;
十一 使用子查询
mysql> SELECT order_num FROM OrderItems WHERE prod_id =  'RGAN01';
mysql> SELECT cust_id FROM Orders WHERE order_num IN (20007,20008);
mysql> SELECT cust_id FROM Orders WHERE order_num IN (SELECT order_num FROM OrderItems WHERE prod_id =  'RGAN01');
mysql> SELECT cust_name,cust_contact FROM Customers WHERE cust_id IN (SELECT cust_id FROM Orders WHERE order_num IN (SELECT order_num FROM OrderItems WHERE prod_id = 'RGAN01'));
mysql> SELECT cust_name,cust_state,(SELECT COUNT(*) FROM Orders WHERE Orders.cust_id = Customers.cust_id) AS orders FROM Customers ORDER BY cust_name;
mysql> SELECT COUNT(*) FROM Orders WHERE cust_id = cust_id;
十二 联结表
内联结 等值联结 自联结 自然联结 外联结
mysql> SELECT vend_name,prod_name,prod_price FROM Vendors,Products WHERE Vendors.vend_id = Products.vend_id;
mysql> SELECT vend_name,prod_name,prod_price FROM Vendors,Products;
mysql> SELECT vend_name,prod_name,prod_price FROM Vendors INNER JOIN  Products ON Vendors.vend_id = Products.vend_id;
mysql> SELECT cust_name,cust_contact FROM Customers AS C,Orders AS O,OrderItems AS OI WHERE C.cust_id = O.cust_id AND OI.order_num = O.order_num AND prod_id = 'RGAN01';

十三 创建高级联结
mysql> SELECT c1.cust_id,c1.cust_name,c1.cust_contact FROM Customers AS c1,Customers AS c2 WHERE c1.cust_name = c2.cust_name AND c2.cust_contact = 'Jim Jones';
mysql> SELECT C.*, O.order_num,O.order_date,OI.prod_id,OI.quantity,OI.item_price FROM Customers AS C,Orders AS O,OrderItems AS OI WHERE C.cust_id = O.cust_id AND OI.order_num = O.order_num AND prod_id = 'RGAN01';
mysql> SELECT Customers.cust_id,Orders.order_num FROM Customers INNER JOIN Orders ON Customers.cust_id = Orders.cust_id;
mysql> SELECT Customers.cust_id,Orders.order_num FROM Customers LEFT OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id;
mysql> SELECT Customers.cust_id,Orders.order_num FROM Customers RIGHT OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id;
mysql> SELECT Customers.cust_id,COUNT(Orders.order_num) AS num_ord FROM Customers INNER JOIN Orders ON Customers.cust_id = Orders.cust_id GROUP BY Customers.cust_id;
mysql> SELECT Customers.cust_id,COUNT(Orders.order_num) AS num_ord FROM Customers LEFT OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id GROUP BY Customers.cust_id;

十四 组合查询
mysql> SELECT cust_name,cust_contact,cust_email FROM Customers WHERE cust_state IN ('IL','IN','MI') UNION SELECT cust_name,cust_contact,cust_email FROM Customers WHERE cust_name = 'Fun4All';
mysql> SELECT cust_name,cust_contact,cust_email FROM Customers WHERE cust_name = 'Fun4All' OR cust_state IN ('IL','IN','MI');
mysql> SELECT cust_name,cust_contact,cust_email FROM Customers WHERE cust_state IN ('IL','IN','MI') UNION ALL SELECT cust_name,cust_contact,cust_email FROM Customers WHERE cust_name = 'Fun4All';
mysql> SELECT cust_name,cust_contact,cust_email FROM Customers WHERE cust_state IN ('IL','IN','MI') UNION SELECT cust_name,cust_contact,cust_email FROM Customers WHERE cust_name = 'Fun4All' ORDER BY cust_name,cust_contact;

十五 插入数据
mysql> INSERT INTO Customers VALUES('1000000006','Toy Land','123 Any Street','New York','NY','11111','USA',NULL,NULL);
mysql> SELECT * INTO CustCopy FROM Customers;
mysql> CREATE TABLE CustCopy AS SELECT * FROM Customers;

十六 跟新和删除数据
mysql> UPDATE Customers SET cust_email = 'kim@thetoystore.com' WHERE cust_id = '1000000005';
mysql> UPDATE Customers SET cust_contact = 'Sam Roberts', cust_email = 'sam@toyland.com' WHERE cust_id = '1000000006';
mysql> UPDATE Customers SET cust_email = NULL WHERE cust_id = '1000000005';
mysql> DELETE FROM Customers WHERE cust_id = '1000000006';

十七 创建和操纵表
mysql> CREATE TABLE Products (prod_id CHAR(10) NOT NULL.....);
mysql> ALTER TABLE Vendors ADD vend_phone CHAR(20);
mysql> ALTER TABLE Vendors DROP COLUMN vend_phone;
mysql> DROP TABLE CustCopy;

十八 使用视图
mysql> SELECT cust_name,cust_contact FROM Customers AS C,Orders AS O,OrderItems AS OI WHERE C.cust_id = O.cust_id AND OI.order_num = O.order_num AND prod_id = 'RGAN01';
mysql> SELECT cust_name,cust_contact FROM ProductCustomers WHERE prod_id = 'RGAN01';
mysql> CREATE VIEW ProductCustomers AS SELECT cust_name,cust_contact,prod_id FROM Customers,Orders,OrderItems WHERE Customers.cust_id = Orders.cust_id AND OrderItems.order_num = Orders.order_num;
mysql> DROP VIEW ProductCustomers;
mysql> SELECT cust_name,cust_contact FROM ProductCustomers WHERE prod_id =  'RGAN01';
mysql> CREATE VIEW CustomersEMailList AS SELECT cust_id,cust_name,cust_email FROM Customers WHERE cust_email IS NOT NULL;
mysql> SELECT * FROM CustomersEMailList;
mysql> SELECT prod_id,quantity,item_price,quantity*item_price AS expanded_price FROM OrderItems WHERE order_num=20008;
mysql> CREATE VIEW OrderItemsExpanded AS SELECT order_num,prod_id,quantity,item_price,quantity*item_price AS expanded_price FROM OrderItems;
mysql> SELECT * FROM OrderItemsExpanded WHERE order_num = 20008;

十九 使用存储过程

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------






















