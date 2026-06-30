-- Day 2: Nth Highest Salary
-- Table: Employee(id, salary)

-- =========================================================
-- Approach 1: Using a parameterized function (MySQL style)
-- This mirrors LeetCode's expected function signature
-- =========================================================
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  DECLARE M INT;
  SET M = N - 1;
  RETURN (
      SELECT
          (SELECT DISTINCT salary
           FROM Employee
           ORDER BY salary DESC
           LIMIT 1 OFFSET M)
  );
END

-- =========================================================
-- Approach 2: Using DENSE_RANK() window function
-- Works well when you want a flexible, readable query
-- (not wrapped as a callable function)
-- =========================================================
SELECT salary AS NthHighestSalary
FROM (
    SELECT salary,
           DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM Employee
) ranked
WHERE rnk = 3;  -- replace 3 with N

-- =========================================================
-- Approach 3: Using a subquery with COUNT of distinct salaries
-- Useful in databases without window functions
-- =========================================================
SELECT DISTINCT e1.salary AS NthHighestSalary
FROM Employee e1
WHERE 3 - 1 = (   -- replace 3 with N
    SELECT COUNT(DISTINCT e2.salary)
    FROM Employee e2
    WHERE e2.salary > e1.salary
);

-- =========================================================
-- Notes:
-- - Approach 1 is what LeetCode's "Nth Highest Salary" expects.
-- - Approach 2 (DENSE_RANK) is the most interview-friendly to explain.
-- - Approach 3 avoids window functions entirely, good to mention
--   if asked "how would you do this without window functions?"
-- =========================================================
