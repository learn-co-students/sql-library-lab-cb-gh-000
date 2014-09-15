describe 'creating schema' do 
  before do
    @db = SQLite3::Database.new(':memory:')
    @sql_runner = SQLRunner.new(@db)
    @sql_runner.execute_schema_sql
  end

  xit '' do 
    expect{@db.execute("")}.to_not raise_exception
  end
end