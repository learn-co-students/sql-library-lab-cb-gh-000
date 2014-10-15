describe 'querying' do 
  before do
    @db = SQLite3::Database.new(':memory:')
    @sql_runner = SQLRunner.new(@db)
    @sql_runner.execute_schema_sql
    @sql_runner.execute_encoded_data
  end
  after do
    File.open('lib/decoded_data.sql', 'w'){ |f| f.truncate(0) }
  end

  it 'selects all of the books names and years in the first series and order them in chronological order by year' do 
    expect(@db.execute("SELECT title, year FROM books WHERE series_id=1 ORDER BY year ASC;")).to eq([["Game of Thrones", 1996], ["A Clash of Kings", 1998], ["A Storm of Swords", 2000]])
  end

  it 'returns the name and motto of the character with the longest motto' do
    expect(@db.execute("SELECT name, motto FROM characters ORDER BY motto ASC LIMIT 1;")).to eq([["Tyrion Lanister", "A Lanister always pays is debts"]])
  end

  it 'determines the most prolific species of characters and return its value and count' do
    expect(@db.execute("SELECT characters.species, count(characters.species) FROM characters GROUP BY characters.species ORDER BY COUNT(*) DESC LIMIT 1")).to eq([["human", 4]])
  end

  it "selects the authors names and their series' subgenres" do 
    expect(@db.execute("SELECT authors.name, subgenres.name FROM authors, subgenres JOIN series ON authors.id = series.author_id AND subgenres.id  = series.subgenre_id;")).to eq([["George R. R. Martin", "medieval"], ["Second Author", "space opera"]])
  end

  it 'selects the series name with the most characters that are the species "human"' do 
    expect(@db.execute('SELECT series.title FROM series JOIN characters ON characters.series_id = series.id WHERE characters.species="human" GROUP BY series.title ORDER BY COUNT(*) DESC limit 1;')).to eq([["A Song of Ice and Fire"]])
  end

  it 'selects all of the character names and their number of books they have appeared in, in descending order' do 
    expect(@db.execute("SELECT characters.name, count(characters.name) FROM characters JOIN character_book on characters.id = character_book.character_id GROUP BY characters.name ORDER BY COUNT(*) DESC;")).to eq([["Character Three",3], ["Character Two", 3],["Daenerys Targaryen", 3], ["Tyrion Lanister", 3], ["Character Four", 1], ["Character One", 1], ["Eddard Stark", 1], ["Lady", 1]])
  end
end