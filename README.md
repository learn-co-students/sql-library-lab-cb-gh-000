---
tags: sql, joins, select, create, insert, update, join tables, intermediate
languages: sql
resources: 3
---

# SQL Fantasy Library

We're going to build a SQL database that will keep track of a library of fantasy series. These types of books can get complex, with many characters that span many books in a series, or just appear in one book, and characters that are species other than human. We will have tables for: Characters, Books, Series, Authors, and Sub-Genres.

## Objectives

1. Become comfortable writing SQL statements to create tables that have complex relations with each other
2. Understand and implement JOINs to write complex `SELECT` statements to query a database

## Section 1: `schema.sql`

Build out the schema for our Fantasy Library database:

1. All tables must have a `PRIMARY KEY` on the id
2. Series have a title and belong to an author and a sub-genre
3. A Sub-Genre has a name
4. Authors have a name
5. Books have a title and year and belong to a series
6. Characters have a name, motto, and species and belong to an author and a series
7. Books have many characters and characters are in many books in a series. How do we accomplish this complex association? With a join table between Characters and Books. This join table (let's call it character_book) will just have -in addition to its primary key- two foreign key columns for the character and book ids. Each row in this join table acts as a relation between a book and a character.

## Section 2: `insert.sql`

Populate the database with the following:

* 2 series
* 2 sub-genres
* 2 authors
* 3 books in each series
* 8 characters
  * 4 characters in each series
    * of each of those 4, make 2 in all of the books in a series, and 2 in just 1 book in a series

* Feel free to make these up if you don't know any Fantasy series :)

## Section 3: `update.sql`

Update the species of the last character in the database. The test for this is pending. Go into `spec/update_spec.rb` and replace "your new species here" with the species.

## Section 4: Querying your database

In `spec/querying_spec.rb`, complete the tests by writing the appropriate queries to satisfy the queries. Note that for this section, the database will be seeded with external data so don't expect it to reflect the data you added above.

## Resources
* [Seldom Blog](http://blog.seldomatt.com/) - [About SQL Joins: The 3 Ring Binder Model](http://blog.seldomatt.com/blog/2012/10/17/about-sql-joins-the-3-ring-binder-model/)
* [Coding Horror](http://blog.codinghorror.com/) - [A Visual Explanation of SQL Joins](http://blog.codinghorror.com/a-visual-explanation-of-sql-joins/)
* [Geeky is Awesome](http://geekyisawesome.blogspot.com/) - [SQL Joins Tutorial](http://geekyisawesome.blogspot.com/2011/03/sql-joins-tutorial.html)
