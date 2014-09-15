---
tags: sql, joins, select, create, insert, update, join tables, intermediate
languages: sql
resources: 3
---

# SQL Sci-Fi Library

We're going to build a SQL database that will keep track of a Sci-Fi Library. The Sci-Fi world is complex. We will have tables for: Characters, Books, Series, Authors, and Sub-Genres.

## Objectives

1. Become comfortable writing SQL statements to create tables that have complex relations with each other
2. Understand and implement JOINs to write complex `SELECT` statements to query a database

## Section 1: `schema.sql`

Build out the schema for our Sci-Fi Library database:

1. All tables must have a `PRIMARY KEY` on the id
2. Series have a title and belong to an author and a sub-genre
3. A Sub-Genre has a name
4. Authors have a name
5. Books have a title and year and belong to a series
6. Characters have a name, age, and species and belong to an author and a series
7. Books have many characters and characters are in many books in a series. How do we accomplish this complex association? With a join table between Characters and Books. This join table (let's call it character_book) will just have two foreign key columns for the character and book ids. Each row in this join table acts as a relation between 

## Section 2: `insert.sql`

Populate the database with the following:

* 2 series
* 3 books in each series
* 8 characters
  * 4 characters in each series
    * of each of those 4, make 2 in all of the books in a series, and 2 in just 1 book in a series
* 2 sub-genres
* 2 authors

## Section 3: `update.sql`

Update the species of your first character.

## Section 4: Querying your database

In `spec/querying_spec.rb`, complete the tests by writing the appropriate `SELECT` statements that satisfy the below queries:

* Ordering books in a series: select all of the books in a series and order them by year, displaying their name
* Major characters: Select all of the characters that appear in all of the books in their series
* Minor characters: Select all of the characters that appear in only one book in their series
* Majority species: Determine the most prolific species in all of the series 
* Majority species by genre: Determine the most prolific species in a given genre
* 


## Resources
* [Seldom Blog](http://blog.seldomatt.com/) - [About SQL Joins: The 3 Ring Binder Model](http://blog.seldomatt.com/blog/2012/10/17/about-sql-joins-the-3-ring-binder-model/)
* [Coding Horror](http://blog.codinghorror.com/) - [A Visual Explanation of SQL Joins](http://blog.codinghorror.com/a-visual-explanation-of-sql-joins/)
* [Geeky is Awesome](http://geekyisawesome.blogspot.com/) - [SQL Joins Tutorial](http://geekyisawesome.blogspot.com/2011/03/sql-joins-tutorial.html)