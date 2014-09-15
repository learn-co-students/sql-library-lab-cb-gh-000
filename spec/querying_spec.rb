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

  xit '' do 
    expect(@db.execute("")).to eq()
  end
end