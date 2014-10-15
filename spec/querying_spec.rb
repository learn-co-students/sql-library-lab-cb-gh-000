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
    expect(@db.execute("")).to eq([["Game of Thrones", 1996], ["A Clash of Kings", 1998], ["A Storm of Swords", 2000]])
  end

  it 'returns the name and motto of the character with the longest motto' do
    expect(@db.execute("")).to eq([["Tyrion Lanister", "A Lanister always pays is debts"]])
  end

  it 'determines the most prolific species of characters and return its value and count' do
    expect(@db.execute("")).to eq([["human", 4]])
  end

  it "selects the authors names and their series' subgenres" do 
    expect(@db.execute("")).to eq([["George R. R. Martin", "medieval"], ["Second Author", "space opera"]])
  end

  it 'selects the series name with the most characters that are the species "human"' do 
    expect(@db.execute('')).to eq([["A Song of Ice and Fire"]])
  end

  it 'selects all of the character names and their number of books they have appeared in, in descending order' do 
    expect(@db.execute("")).to eq([["Character Three",3], ["Character Two", 3],["Daenerys Targaryen", 3], ["Tyrion Lanister", 3], ["Character Four", 1], ["Character One", 1], ["Eddard Stark", 1], ["Lady", 1]])
  end
end