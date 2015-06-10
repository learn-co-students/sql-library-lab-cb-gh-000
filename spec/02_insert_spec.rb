describe 'inserting' do 
  before do
    @db = SQLite3::Database.new(':memory:')
    @sql_runner = SQLRunner.new(@db)
    @sql_runner.execute_schema_sql
    @sql_runner.execute_insert_sql
  end

  it "has 2 series" do
    expect(@db.execute("SELECT COUNT(*) FROM series;").flatten[0]).to eq(2)
  end

  it "has 6 books" do
    expect(@db.execute("SELECT COUNT(*) FROM books;").flatten[0]).to eq(6)
  end

  it "has 8 characters" do
    expect(@db.execute("SELECT COUNT(*) FROM characters;").flatten[0]).to eq(8)
  end

  it "has 2 subgenres" do
    expect(@db.execute("SELECT COUNT(*) FROM subgenres;").flatten[0]).to eq(2)
  end

  it "has 2 authors" do
    expect(@db.execute("SELECT COUNT(*) FROM authors;").flatten[0]).to eq(2)
  end

  it 'has 16 joins in character_books' do 
    expect(@db.execute("SELECT COUNT(*) FROM character_books;").flatten[0]).to eq(16)
  end

end
