二：创建一个数据库并插入数据   
mysql> CREATE DATABASE mysql_shiyan;
mysql> use mysql_shiyan;
mysql> show tables;
mysql> CREATE TABLE employee (id int(10),name char(20),phone int(12));
mysql> CREATE TABLE department
    -> (
    -> dpt_name CHAR(20),
    -> dpt_phone INT(12)
    -> );
mysql> INSERT INTO employee(id,name,phone) VAlUES(01,'Tom',110110110);
mysql> INSERT INTO employee VALUES(01,'Jack',119119119);
mysql> INSERT INTO employee(id,name) VALUES(03,'Rose');
mysql> SELECT * FROM employee;
+------+------+-----------+
| id   | name | phone     |
+------+------+-----------+
|    1 | Tom  | 110110110 |
|    1 | Jack | 119119119 |
|    3 | Rose |      NULL |
+------+------+-----------+
3 rows in set (0.00 sec)

-------------------------------------------------------------------
三 约束   --- SQL3
mysql> DROP DATABASE mysql_shiyan;
mysql> source /home/kobe/home/kobe/SQL/SQL3/MySQL-03-01.sql;
mysql> use mysql_shiyan ;
mysql> show tables;
+------------------------+
| Tables_in_mysql_shiyan |
+------------------------+
| department             |
| employee               |
| project                |
+------------------------+

-------------------------------------------------------------------

------------------------------------------------------------------------
四 select语句详解  ---SQL4

mysql> SELECT * FROM employee;
+----+------+------+--------+--------+--------+
| id | name | age  | salary | phone  | in_dpt |
+----+------+------+--------+--------+--------+
|  1 | Tom  |   26 |   2500 | 119119 | dpt4   |
|  2 | Jack |   24 |   2500 | 120120 | dpt2   |
|  3 | Rose |   22 |   2800 | 114114 | dpt3   |
|  4 | Jim  |   35 |   3000 | 100861 | dpt1   |
|  5 | Mary |   21 |   3000 | 100101 | dpt2   |
|  6 | Alex |   26 |   3000 | 123456 | dpt1   |
|  7 | Ken  |   27 |   3500 | 654321 | dpt1   |
|  8 | Rick |   24 |   3500 | 987654 | dpt3   |
|  9 | Joe  |   31 |   3600 | 110129 | dpt2   |
| 10 | Mike |   23 |   3400 | 110110 | dpt4   |
| 11 | Jobs | NULL |   3600 |  19283 | dpt2   |
| 12 | Tony | NULL |   3400 | 102938 | dpt3   |
+----+------+------+--------+--------+--------+
12 rows in set (0.00 sec)

mysql> SELECT * FROM department;
+----------+------------+
| dpt_name | people_num |
+----------+------------+
| dpt1     |         11 |
| dpt2     |         12 |
| dpt3     |         10 |
| dpt4     |         15 |
+----------+------------+
4 rows in set (0.00 sec)

mysql> SELECT * FROM project;
+----------+-----------+------------+------------+--------+
| proj_num | proj_name | start_date | end_date   | of_dpt |
+----------+-----------+------------+------------+--------+
|        1 | proj_a    | 2015-01-15 | 2015-01-31 | dpt2   |
|        2 | proj_b    | 2015-01-15 | 2015-02-15 | dpt1   |
|        3 | proj_c    | 2015-02-01 | 2015-03-01 | dpt4   |
|        4 | proj_d    | 2015-02-15 | 2015-04-01 | dpt3   |
|        5 | proj_e    | 2015-02-25 | 2015-03-01 | dpt4   |
|        6 | proj_f    | 2015-02-26 | 2015-03-01 | dpt2   |
+----------+-----------+------------+------------+--------+
6 rows in set (0.00 sec)

-----------------------------------约束---------------------------------
mysql> INSERT INTO department(dpt_name,people_num) VALUES('dpt1',11);
mysql> INSERT INTO department(dpt_name) VALUES('dpt2');
mysql> SELECT * FROM department;
+----------+------------+
| dpt_name | people_num |
+----------+------------+
| dpt1     |         11 |
| dpt2     |         10 |
+----------+------------+
2 rows in set (0.00 sec)
mysql> INSERT INTO employee VALUES(02,'Jack',30,3500,114114,'dpt3');
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`mysql_shiyan`.`employee`, CONSTRAINT `emp_fk` FOREIGN KEY (`in_dpt`) REFERENCES `department` (`dpt_name`))
mysql> INSERT INTO employee VALUES(02,'Jack',30,3500,114114,'dpt2');
mysql> INSERT INTO employee(id,name,salary,phone,in_dpt) VALUES(03,'Jim',3400,119119,'dpt2');
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO employee(id,name,age,phone,in_dpt) VALUES(04,'Bob',23,123456,'dpt1');
Query OK, 1 row affected, 1 warning (0.02 sec)
mysql> SELECT * FROM employee;+----+------+------+--------+--------+--------+
| id | name | age  | salary | phone  | in_dpt |
+----+------+------+--------+--------+--------+
|  1 | Tom  |   30 |   3500 | 110110 | dpt1   |
|  2 | Jack |   30 |   3500 | 114114 | dpt2   |
|  3 | Jim  | NULL |   3400 | 119119 | dpt2   |
|  4 | Bob  |   23 |      0 | 123456 | dpt1   |
+----+------+------+--------+--------+--------+
4 rows in set (0.00 sec)
------------------------------------------------------------------------------
mysql> DROP DATABASE mysql_shiyan;
mysql> source /home/kobe/home/kobe/SQL/SQL4/MySQL-04-01.sql;
mysql> source /home/kobe/home/kobe/SQL/SQL4/MySQL-04-02.sql;

mysql> SELECT name,age from employee where age>25;
mysql> SELECT name,age from employee where name='Mary';
mysql> SELECT name,age from employee where age>25 AND age<30;
mysql> SELECT name,age from employee where age<25 OR age>30;
mysql> SELECT name,age from employee where age BETWEEN 25 AND 30;
mysql> SELECT name,age,in_dpt from employee where in_dpt IN ('dpt3','dpt4');
mysql> SELECT name,age,in_dpt from employee where in_dpt NOT IN ('dpt3','dpt4');
mysql> SELECT name,age,phone  from employee where phone LIKE '1101__';
mysql> SELECT name,age,phone from employee where name LIKE 'J%';
mysql> SELECT name,age,phone from employee ORDER BY age;
mysql> SELECT name,age,phone from employee ORDER BY age DESC;
mysql> SELECT MAX(age) AS max_age,MIN(age) FROM employee;
+---------+----------+
| max_age | MIN(age) |
+---------+----------+
|      35 |       21 |
+---------+----------+
1 row in set (0.00 sec)

mysql> SELECT COUNT(name),SUM(salary),AVG(age) FROM employee;
+-------------+-------------+----------+
| COUNT(name) | SUM(salary) | AVG(age) |
+-------------+-------------+----------+
|          12 |       37800 |  25.9000 |
+-------------+-------------+----------+
1 row in set (0.00 sec)

mysql> SELECT of_dpt,COUNT(proj_name) AS count_project FROM project WHERE of_dpt IN (SELECT in_dpt FROM employee WHERE name='Tom');
+--------+---------------+
| of_dpt | count_project |
+--------+---------------+
| dpt4   |             2 |
+--------+---------------+
1 row in set (0.00 sec)

mysql> SELECT id,name,in_dpt,people_num FROM employee JOIN department ON employee.in_dpt=department.dpt_name ORDER BY id;

mysql> SELECT id,name,in_dpt,people_num FROM employee,department WHERE employee.in_dpt=department.dpt_name ORDER BY id;
+----+------+--------+------------+
| id | name | in_dpt | people_num |
+----+------+--------+------------+
|  1 | Tom  | dpt4   |         15 |
|  2 | Jack | dpt2   |         12 |
|  3 | Rose | dpt3   |         10 |
|  4 | Jim  | dpt1   |         11 |
|  5 | Mary | dpt2   |         12 |
|  6 | Alex | dpt1   |         11 |
|  7 | Ken  | dpt1   |         11 |
|  8 | Rick | dpt3   |         10 |
|  9 | Joe  | dpt2   |         12 |
| 10 | Mike | dpt4   |         15 |
| 11 | Jobs | dpt2   |         12 |
| 12 | Tony | dpt3   |         10 |
+----+------+--------+------------+

----------------------------------------------------------------------------------
五 修改和删除

mysql> DROP DATABASE mysql_shiyan;
mysql> source  /home/kobe/home/kobe/SQL/SQL5/MySQL-05.sql;
mysql> DROP DATABASE test_01;
mysql> RENAME TABLE table_1 TO table_2;
mysql> DROP TABLE table_2;
mysql> ALTER TABLE employee ADD height INT(4) DEFAULT 170;
mysql> ALTER TABLE employee ADD weight INT(4) DEFAULT 120 AFTER age;
mysql> ALTER TABLE employee ADD test INT(10) DEFAULT 11 FIRST;
mysql> ALTER TABLE employee DROP test;
mysql> SELECT * FROM employee;
mysql> ALTER TABLE employee CHANGE height shengao INT(4) DEFAULT 170;
mysql> SELECT * FROM employee WHERE name='Tom';
mysql> UPDATE employee SET age=21,salary=3000 WHERE name='Tom';
mysql> SELECT * FROM employee WHERE name='Tom';
mysql> DELETE FROM employee WHERE name='Tom';
mysql> SELECT * FROM employee;

------------------------------------------------------------------------------------
六 其他
1 创建索引
mysql> ALTER TABLE employee ADD INDEX idx_id(id);
mysql> CREATE INDEX idx_name ON employee(name);
mysql> SHOW INDEX FROM employee;
2 视图
mysql> CREATE VIEW v_emp (v_name,v_age,v_phone) AS SELECT name,age,phone FROM employee;
mysql> SELECT * FROM v_emp;
3 导入导出
mysql> LOAD DATA INFILE '/home/kobe/home/kobe/SQL/in.txt' INTO TABLE employee;
mysql> SELECT * INTO OUTFILE '/home/kobe/home/kobe/SQL/outfile.txt' FROM employee;
（可能有写权限问题）
4 备份与恢复
 mysqldump -u root mysql_shiyan -p > bak.sql;
Enter password: 
source bak.sql
































