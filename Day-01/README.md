# Day 01 — Second Highest Salary

**Date:** 29 June 2026  
**Topic:** SQL — Subqueries & Window Functions  
**Platform:** LeetCode #176  
**Difficulty:** 🟢 Easy  
**Status:** ✅ Solved

---

## 📝 Problem

Write a SQL query to find the **second highest salary** from the `Employee` table.  
If no second highest salary exists, return `NULL`.

---

## 💡 Approaches

### Approach 1 — LIMIT with OFFSET *(Most Common in Interviews)*

```sql
SELECT IFNULL(
    (SELECT DISTINCT salary
     FROM Employee
     ORDER BY salary DESC
     LIMIT 1 OFFSET 1),
    NULL
) AS SecondHighestSalary;
```

**How it works:**
- `DISTINCT` removes duplicate salaries
- `ORDER BY salary DESC` sorts highest to lowest
- `OFFSET 1` skips the first (highest) salary
- `LIMIT 1` picks exactly the next one
- `IFNULL(...)` returns NULL if no result is found

---

### Approach 2 — Nested MAX() Subquery

```sql
SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);
```

**How it works:**
- Inner query finds the maximum salary
- Outer query finds the maximum salary below that

---

### Approach 3 — DENSE_RANK() Window Function *(Most Scalable)*

```sql
SELECT salary AS SecondHighestSalary
FROM (
    SELECT salary,
           DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM Employee
) ranked
WHERE rnk = 2
LIMIT 1;
```

**How it works:**
- `DENSE_RANK()` assigns ranks without gaps
- We filter for rank = 2

---

## 🔑 Key Concepts Used

| Concept | What It Does |
|---------|-------------|
| `DISTINCT` | Removes duplicate values |
| `ORDER BY DESC` | Sorts highest to lowest |
| `LIMIT n OFFSET m` | Skips m rows, returns n rows |
| `IFNULL(x, y)` | Returns y if x is NULL |
| `MAX()` | Returns the highest value |
| `DENSE_RANK()` | Ranks without skipping numbers |
| Subquery | A query nested inside another query |

---

## ⚠️ Common Mistake

Using `RANK()` instead of `DENSE_RANK()`:

```
Salaries: 300, 300, 200, 100

RANK()        → 1, 1, 3, 4   ❌ Skips rank 2
DENSE_RANK()  → 1, 1, 2, 3   ✅ No gaps
```

Always use `DENSE_RANK()` for "Nth highest" problems.

---

## ⏱️ Complexity

| Approach | Time | Space |
|----------|------|-------|
| LIMIT/OFFSET | O(n log n) | O(1) |
| Nested MAX | O(n) | O(1) |
| DENSE_RANK | O(n log n) | O(n) |

---

## 🎯 Interview Follow-Up Questions

1. **What if there are duplicate salaries?** → `DISTINCT` handles this
2. **How would you find the Nth highest salary?** → Use `OFFSET N-1` or `DENSE_RANK() = N`
3. **What's the difference between RANK and DENSE_RANK?** → RANK skips numbers after ties; DENSE_RANK doesn't
4. **Can you write this as a reusable SQL function?** → Yes, using `CREATE FUNCTION`
5. **How would you handle NULL salaries in the table?** → Add `WHERE salary IS NOT NULL`

---

## 🧠 What I Learned Today

- `LIMIT` and `OFFSET` are powerful for pagination-style SQL problems
- `DENSE_RANK()` is more reliable than `RANK()` for "Nth highest" queries
- Always wrap nullable subqueries in `IFNULL()` to handle edge cases
- The same problem can be solved multiple ways — knowing all approaches impresses interviewers
- Window functions like `DENSE_RANK()` are increasingly common in modern SQL interviews

---

## 📂 Files in This Folder

| File | Description |
|------|-------------|
| `question.md` | Problem statement and table schema |
| `solution.sql` | All 3 approaches with detailed comments |
| `output.png` | Screenshot of successful query output |
| `README.md` | This file |

---

*Part of my [100 Days of Data Analytics](../README.md) challenge.*
