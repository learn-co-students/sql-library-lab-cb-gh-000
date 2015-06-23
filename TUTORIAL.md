# Guide to Solving and Reviewing SQL Library

## Overview

This lab requires us to create a schema for a library, including Characters, Books, Series, Authors, and Sub-Genres.

We will be practicing some of the basic CRUD operations in SQL, including inserting (creating), updating, and querying (reading).

Before getting started, let's take a look at the directories and files that we'll be working with:

1) `/bin`
  
- `environment.rb`: 
  - Requires bundler (which lets us use a manifest file for all our gems (`Gemfile`) and bundles every gem we list there, loading not only the gems that are listed but also all of their dependencies.
  - Requires base64, which this lab uses for encoding and decoding information to hide parts of the solution from view (see `#execute_encoded_data` in `bin/sql_runner.rb`).
  - Requires two more files that are needed in order to run the spec - `sql_runner` and `querying.rb`.

- `sql_runner.rb`:
  - Requires the `environment` file.
  - Defines a `SQLRunner` class that has methods for reading files and executing the SQL those files contain. These methods are called throughout the spec files. Take a look at those files to see how they are being used.

2) `/lib` and `/spec`:

- `decoded_data.sql` is going to remain untouched by us as we solve this lab. The `execute_encoded_data` method in the `SQLRunner` class uses that file as a place to write the `decoded_data` and read from it.

- The rest of the files here are where we'll write our solution. The order of the spec files is the same order in which we will work with these files:
  - `schema.sql`, `insert.sql`, and `update.sql` are the files we'll use for writing SQL statements to make the first three spec files pass.
  - `querying.rb` has a bunch of empty Ruby methods in it. To make the fourth spec file pass, we'll fill these methods with SQL statements.
  
## Schema Spec: Creating Tables

For all of the tests in the `01_schema_spec.rb`, we'll write our code in `lib/schema.sql`.

### 1) Creating Tables for Each "Resource" in Our Domain Model: series, subgenres, authors, books, and characters

When we run `rspec` for the first time, the first failure we're getting is 

```bash
Failure/Error: expect{@db.execute("SELECT title FROM series;")}.to_not raise_exception
       expected no Exception, got #<SQLite3::SQLException: no such table: series>
```

The part of that error that stands out to me is `no such table: series`. Let's creat that table in `lib/schema.sql`. Looking at the the schema spec file is a good idea at this point so we can see all the fields our `series` table needs to have: `title`, `author_id`, `subgenre_id`, and `id` as a primary key.

```sql
CREATE TABLE series (
  id INTEGER PRIMARY KEY,
  title TEXT,
  author_id INTEGER,
  subgenre_id INTEGER
);
```

The above code gets the first four tests passing. The next failure we have is `no such table: subgenres`. The spec tells us the `subgenres` table needs just a `name` and an `id`:

```sql
CREATE TABLE subgenres (
  id INTEGER PRIMARY KEY,
  name TEXT
);
```

Now we have two more tests passing! On to the `authors` table, again with just a `name` and an `id`:

```sql
CREATE TABLE authors (
  id INTEGER PRIMARY KEY,
  name TEXT
);
```

The next table we need to create in the schema file is `books`. A book has a `title`, `year`, `series_id`, and `id`:

```sql
CREATE TABLE books (
  id INTEGER PRIMARY KEY,
  title TEXT,
  year DATE,
  series_id INTEGER
);
```

Notice that instead of using an `INTEGER` field for `year`, we can use a `DATE` field. To discover all the data types we can use in SQL, this is a great resource: [W3Schools SQL General Data Types](http://www.w3schools.com/sql/sql_datatypes_general.asp).

Now we have four more tests passing and it's time to create the `characters` table. The fields this table needs are `id`, `name`, `species`, `motto`, `series_id`, and `author_id`:

```sql
CREATE TABLE characters (
  id INTEGER PRIMARY KEY,
  name TEXT,
  species TEXT,
  motto TEXT,
  series_id INTEGER,
  author_id INTEGER
);

```

Now all of the tests for the `characters` table are passing.

#### A Note About Foreign Keys

You may have noticed that lots of the tables we just created have fields that refer to the `id` field of a different table. These are called foreign keys. For example, the `books` table has a `series_id`.  This means that for any given book in our database, its row will contain the `id` of a series that it "belongs to". Why not have a `book_id` in the `series` table? Because that would mean that a `series` could only be associated with a single book. Since a book is only associated with one series, the foreign key beongs in the `books` table. 

Because of this foreign key, we can find out which series a particular book "belongs to" by writing a query that asks for the row in the `series` table where the `id` is the same as the `series_id` of that book.

Likewise, if we want to find out which books a particular series has, we can simply write a query that asks for all the rows in the `books` table where the `series_id` is the `id` of the series we are asking about.

### 2) Creating Join Tables

Now that we know about foreign keys, let's talk about join tables. Remember that creating a `series_id` in the `books` table represents a "belongs to / has many" relationship between books and series. But what about characters and books? How are those related? In series books, a character can be in many different books, and a book has many characters.

We call this relationship "many to many". This is where join tables come in to play. A join table's responsibility is to create this "many to many" relationship between two other tables.

A good name for a join table between characters and books is `character_books`. It sounds a little contrived, because there is no such thing as a "character book", but unlike our other tables up to this point this one is not representing a "real world" resource like a book or a character. We're just respresenting a relationship here.

Here's how we'll create this table:

```sql
CREATE TABLE character_books (
  id INTEGER PRIMARY KEY,
  character_id INTEGER,
  book_id INTEGER
);
```

We need two foreign keys to make this table work, since a "character book" belongs to both a single book and single character.

This table is going to be very useful when we need to find out all the books a particular character was in, or all the characters that were in a particular book.

We've created a pretty complex schema for our series book domain model, and it's time to move on to inserting!


## Insert Spec: Inserting Data into our Tables

For this portion of the lab, we'll be writing SQL statements to insert data in `lib/insert.sql`.

The next error we're getting is:

```bash
Failure/Error: expect(@db.execute("SELECT COUNT(*) FROM series;").flatten[0]).to eq(2)
       
       expected: 2
            got: 0
```
We need to insert two series into the `series` table:

```sql
INSERT INTO series (title, author_id, subgenre_id)
VALUES
("Series One", 1, 1),
("Series Two", 2, 2);
```

*Note: Specifying the field names in the `INSERT INTO` statement is not required, but it is recommended. Without specifying this, the data in our inserted `VALUES` has to be in the order in which the fields were created in our `CREATE TABLE` statement. It's a pain to look back and forth between these two statemets (which are also in separate files), so it's best practice just to be clear and specify the order like the above. In addition to making it easier for us to write all the data we're inserting, it also makes our code more readable!*

*Also Note: We never have to include `id` in the INSERT statment. The `id` will populate automatically and will increment to ensure each row's `id` is unique.*

This gets us to the next failure: we need to insert six books into the `books` table:

```sql
INSERT INTO books (title, year, series_id)
VALUES
("Book 1", 1981, 1),
("Book 2", 1982, 2),
("Book 3", 1983, 3),
("Book 4", 1984, 4),
("Book 5", 1985, 5),
("Book 6", 1986, 6);
```

Next, eight characters need to be inserted into the `characters` table:

```sql
INSERT INTO characters (name, species, motto, series_id, author_id)
VALUES
("Char 1", "Human", "Motto 1", 1, 1),
("Char 2", "Human", "Motto 2", 1, 1),
("Char 3", "Human", "Motto 3", 1, 1),
("Char 4", "Human", "Motto 4", 1, 1),
("Char 5", "Human", "Motto 5", 1, 1),
("Char 6", "Human", "Motto 6", 1, 1),
("Char 7", "Human", "Motto 7", 1, 1),
("Char 8", "Human", "Motto 8", 1, 1);
```

Now we need to insert two subgenres into the `subgenres` table:

```sql
INSERT INTO subgenres (name)
VALUES
("Subgenre 1"),
("Subgenre 2");
```

...and two authors:

```sql
INSERT INTO authors (name)
VALUES
("Author 1"),
("Author 2");
```

...and 16 joins!

```sql
INSERT INTO character_books (character_id, book_id)
VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 2),
(8, 2),
(1, 3),
(2, 3),
(3, 3),
(4, 3),
(5, 3),
(6, 3),
(7, 3),
(8, 3);
```

And the inserting is done!


## Update Spec: Changing the Value of a Field

We'll write the code for the update spec in `lib/update.sql`.

The next test that's failing is the last character in the characters table should have a species of "Martian". Let's make that happen:

```sql
UPDATE characters
SET species = "Martian"
WHERE id = (SELECT MAX(id) FROM characters);
```
Using `SELECT MAX(id) FROM characters` allows us to make sure the character we are updating is the last one in the `characters` table. We could just hard code it to 8 to get the test to pass, but that code would break as soon as another character was added.

This brings us up to the querying spec!

## Querying Spec

For the tests in the last spec file, we'll be writing SQL statements inside the empty methods provided in `lib/querying.rb`.

The first method needs to select all of the books titles and years in the first series and order them chronologically:

```ruby
def select_books_titles_and_years_in_first_series_order_by_year
  "SELECT title, year FROM books WHERE series_id = 1 ORDER BY year"
end
```

Now we need a method that returns the name and motto of the character with the longest motto:

```ruby
def select_name_and_motto_of_char_with_longest_motto
  "SELECT name, motto FROM characters ORDER BY LENGTH(motto) DESC LIMIT 1"
end
```

The next query we need to construct will select the value and count of the "most prolific" species - this means the species that is most common among all the characters.

```ruby
def select_value_and_count_of_most_prolific_species
  "SELECT species, COUNT(*) FROM characters GROUP BY species ORDER BY COUNT(species) DESC LIMIT 1"
end
```

The next method needs to return each author's name along with the names of their series' subgenres.

```ruby
def select_name_and_series_subgenres_of_authors
  "SELECT authors.name, subgenres.name FROM authors JOIN series ON series.author_id = authors.id JOIN subgenres ON series.subgenre_id = subgenres.id"
end
```

The next method returns the title of the series with the most human characters.

```ruby
def select_series_title_with_most_human_characters
  "SELECT series.title FROM characters JOIN series ON characters.series_id = series.id WHERE characters.species = 'human' group by series_id order by count(*) desc limit 1"
end
```

The final query selects each of the character names along with the number of books they are in. The result needs to be ordered by the number of books they've appeared in (desc).

```ruby
def select_character_names_and_number_of_books_they_are_in
  "SELECT characters.name, COUNT(*) as book_count FROM characters JOIN character_books ON characters.id = character_books.character_id GROUP BY characters.name ORDER BY book_count DESC"
end
```

With this final query done, all of our tests are passing!
