-- ============================================================
-- Problem  : Second Highest Salary
-- Date     : 29 June 2026
-- Author   : Bhoomi Chowksey
-- ============================================================


-- ============================================================
-- APPROACH 1: Using LIMIT and OFFSET (Most Common Answer)
-- ============================================================
-- Logic:
--   Step 1 → Remove duplicates using DISTINCT
--   Step 2 → Sort salaries highest first using ORDER BY DESC
--   Step 3 → Skip the first (highest) salary using OFFSET 1
--   Step 4 → Take the next one using LIMIT 1
--   Step 5 → Wrap in IFNULL to return NULL if no result found

SELECT
    IFNULL(
        (
            SELECT DISTINCT salary
            FROM Employee
            ORDER BY salary DESC
            LIMIT 1 OFFSET 1
        ),
        NULL
    ) AS SecondHighestSalary;


-- ============================================================
-- APPROACH 2: Using Subquery with MAX()
-- ============================================================
-- Logic:
--   Step 1 → Find the overall MAX salary (that's the highest)
--   Step 2 → Find MAX of remaining salaries after excluding the highest
--   This naturally gives the second highest

SELECT
    MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (
    SELECT MAX(salary)
    FROM Employee
);


-- ============================================================
-- APPROACH 3: Using DENSE_RANK() Window Function
-- ============================================================
-- Logic:
--   Step 1 → Assign a dense rank to each unique salary (highest = rank 1)
--   Step 2 → Pick the row where rank = 2
--   DENSE_RANK handles duplicate salaries correctly (no gaps in ranking)

SELECT salary AS SecondHighestSalary
FROM (
    SELECT
        salary,
        DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM Employee
) ranked
WHERE rnk = 2
LIMIT 1;


-- ============================================================
-- WHY USE DENSE_RANK INSTEAD OF RANK?
-- ============================================================
-- Example:
--   Salaries: 300, 300, 200, 100
--
--   RANK()        → 1, 1, 3, 4   (skips rank 2)
--   DENSE_RANK()  → 1, 1, 2, 3   (no gaps — correct!)
--
-- For "Nth highest salary" problems, always prefer DENSE_RANK.


-- ============================================================
-- INTERVIEW FOLLOW-UP: Nth Highest Salary (Using Function)
-- ============================================================
-- Companies sometimes ask: "Can you write this as a reusable function?"

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    SET N = N - 1;
    RETURN (
        SELECT DISTINCT salary
        FROM Employee
        ORDER BY salary DESC
        LIMIT 1 OFFSET N
    );
END;

-- Usage:
-- SELECT getNthHighestSalary(2);   -- Returns second highest
-- SELECT getNthHighestSalary(3);   -- Returns third highest
