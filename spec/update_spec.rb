describe 'updating' do 
  before do
    @db = SQLite3::Database.new(':memory:')
    @sql_runner = SQLRunner.new(@db)
    @sql_runner.execute_schema_sql
    @sql_runner.execute_insert_sql
    @sql_runner.execute_update_sql
  end

  it 'updates the species of the last character in the characters table' do 
    expect(@db.execute("your query here").flatten[0]).to eq("your new species here")
  end
end
