# 📝 Question: Second Highest Salary

**Platform:** LeetCode #176  
**Difficulty:** Easy  
**Topic:** SQL - Subquery / Window Functions  
**Date:** 29 June 2026

---

## Problem Statement

Write a SQL query to get the **second highest salary** from the `Employee` table.

```
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
```

**Expected Output:**

```
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
```

---

## Edge Case

If there is no second highest salary (only one employee), the query should return `NULL`:

```
+---------------------+
| SecondHighestSalary |
+---------------------+
| NULL                |
+---------------------+
```

---

## Table Schema

```sql
CREATE TABLE Employee (
    id     INT,
    salary INT
);

INSERT INTO Employee VALUES (1, 100);
INSERT INTO Employee VALUES (2, 200);
INSERT INTO Employee VALUES (3, 300);
```

---

## Try It Yourself First!

Before looking at the solution, think about:

1. How do you remove duplicate salaries?
2. How do you sort salaries in descending order?
3. How do you pick just the second one?
4. What happens when there's only one unique salary?
