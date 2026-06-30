# Day 2

## Problem

Nth Highest Salary

## Difficulty

Medium

## Concepts Used

- DISTINCT
- ORDER BY
- LIMIT / OFFSET
- DENSE_RANK() window function
- Correlated subqueries
- SQL functions (parameterized queries)

## Approach

I solved this problem in three ways:

1. **Function-based approach** - wrapped the LIMIT/OFFSET logic inside a reusable
   SQL function `getNthHighestSalary(N)`, which is the standard format LeetCode expects.
2. **DENSE_RANK() approach** - ranked salaries in descending order, handling duplicate
   salaries correctly (unlike RANK(), ties don't create gaps in ranking), then filtered
   for the row where rank equals N.
3. **Correlated subquery approach** - for each salary, counted how many distinct salaries
   were greater than it. If that count equals N-1, it's the Nth highest. This avoids
   window functions entirely.

## Time Complexity

O(n log n) for all three approaches, due to sorting/ranking.

## What I Learned

- DENSE_RANK() handles duplicate salaries correctly, while ROW_NUMBER() would treat
  duplicates as separate ranks (which is wrong for this problem).
- Wrapping logic in a SQL function makes it reusable for any value of N.
- The correlated subquery approach is a good fallback when window functions aren't
  available in older database systems.
- This problem is a direct generalization of Day 1's "Second Highest Salary" (N=2).
- Edge case handling (N larger than available distinct salaries) is important and
  should return NULL.

## Interview Tips

- Be ready to explain the difference between `RANK()`, `DENSE_RANK()`, and `ROW_NUMBER()`.
- Common follow-up: "How would you find the Nth highest salary per department?"
  (Hint: use `PARTITION BY department_id` in the window function.)
- Common follow-up: "What if salaries can be NULL?" (Discuss filtering with `WHERE salary IS NOT NULL`.)
- Be prepared to discuss performance: indexing the salary column helps with sorting at scale.

## Files in This Folder

| File | Description |
|------|--------------|
| `question.md` | Problem statement and constraints |
| `solution.sql` | Three different SQL approaches with comments |
| `README.md` | This file - documentation of approach and learnings |
