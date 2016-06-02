describe 'creating schema' do
  before do
    @db = SQLite3::Database.new(':memory:')
    @sql_runner = SQLRunner.new(@db)
    @sql_runner.execute_schema_sql
  end

  describe 'series table' do 
    it "creates a series table with a title field" do
      expect{@db.execute("SELECT title FROM series;")}.to_not raise_exception
    end

    it "creates a series table with a author_id field" do
      expect{@db.execute("SELECT author_id FROM series;")}.to_not raise_exception
    end

    it "creates a series table with a subgenre_id field" do
      expect{@db.execute("SELECT subgenre_id FROM series;")}.to_not raise_exception
    end

    it "creates a series table with an id as a primary key" do
      expect(@db.execute("PRAGMA table_info(series);").detect { |arr| arr[-1] == 1 && arr[2] == "INTEGER" }.length).to eq(6)
    end
  end

  describe 'subgenres table' do 
    it "creates a subgenres table with a name field" do
      expect{@db.execute("SELECT name FROM subgenres;")}.to_not raise_exception
    end

    it "creates a subgenres table with an id as a primary key" do
      expect(@db.execute("PRAGMA table_info(subgenres);").detect { |arr| arr[-1] == 1 && arr[2] == "INTEGER" }.length).to eq(6)
    end
  end

  describe 'authors table' do 
    it "creates a authors table with a name field" do
      expect{@db.execute("SELECT name FROM authors;")}.to_not raise_exception
    end

    it "creates a authors table with an id as a primary key" do
      expect(@db.execute("PRAGMA table_info(authors);").detect { |arr| arr[-1] == 1 && arr[2] == "INTEGER" }.length).to eq(6)
    end
  end

  describe 'books table' do 
    it "creates a books table with a title field" do
      expect{@db.execute("SELECT title FROM books;")}.to_not raise_exception
    end

    it "creates a books table with a year field" do
      expect{@db.execute("SELECT year FROM books;")}.to_not raise_exception
    end

    it "creates a books table with a series_id field" do
      expect{@db.execute("SELECT series_id FROM books;")}.to_not raise_exception
    end

    it "creates a books table with an id as a primary key" do
      expect(@db.execute("PRAGMA table_info(books);").detect { |arr| arr[-1] == 1 && arr[2] == "INTEGER" }.length).to eq(6)
    end
  end

  describe 'characters table' do 
    it "creates a characters table with a name field" do
      expect{@db.execute("SELECT name FROM characters;")}.to_not raise_exception
    end

    it "creates a characters table with a species field" do
      expect{@db.execute("SELECT species FROM characters;")}.to_not raise_exception
    end

    it "creates a characters table with a motto field" do
      expect{@db.execute("SELECT motto FROM characters;")}.to_not raise_exception
    end

    it "creates a characters table with a series_id field" do
      expect{@db.execute("SELECT series_id FROM characters;")}.to_not raise_exception
    end

    it "creates a characters table with a author_id field" do
      expect{@db.execute("SELECT author_id FROM characters;")}.to_not raise_exception
    end

    it "creates a characters table with an id as a primary key" do
      expect(@db.execute("PRAGMA table_info(characters);").detect { |arr| arr[-1] == 1 && arr[2] == "INTEGER" }.length).to eq(6)
    end
  end

  describe 'character_books join table' do
    it "creates a character_books table with an id as a primary key" do
      expect(@db.execute("PRAGMA table_info(character_books);").detect { |arr| arr[-1] == 1 && arr[2] == "INTEGER" }.length).to eq(6)
    end

    it "creates a character_books table with a book_id field" do
      expect{@db.execute("SELECT book_id FROM character_books;")}.to_not raise_exception
    end

    it "creates a character_books table with a character_id field" do
      expect{@db.execute("SELECT character_id FROM character_books;")}.to_not raise_exception
    end
  end
end
