# Day 2 - Nth Highest Salary

## Problem Statement

Write a SQL query to find the **Nth highest salary** from the `Employee` table.
If there is no Nth highest salary, the query should return `NULL`.

This is a follow-up to Day 1's "Second Highest Salary" problem, generalized for any N.

## Table: Employee

| Column Name | Type |
|-------------|------|
| id          | int  |
| salary      | int  |

## Example

Input: Employee table

| id | salary |
|----|--------|
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |

N = 2

Output:

| getNthHighestSalary(2) |
|-------------------------|
| 200                     |

## Constraints

- Salaries are not guaranteed to be unique.
- N can be any positive integer.
- Handle the case where N is larger than the number of distinct salaries (return NULL).

## Concepts to Think About

- How is this different from "Second Highest Salary"?
- How would you write this as a reusable function (parameterized by N)?
- What's the difference between `LIMIT/OFFSET` and `DENSE_RANK()` approaches when N changes dynamically?
