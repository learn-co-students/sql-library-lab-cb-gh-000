describe 'updating' do 
  before do
    @db = SQLite3::Database.new(':memory:')
    @sql_runner = SQLRunner.new(@db)
    @sql_runner.execute_schema_sql
    @sql_runner.execute_insert_sql
    @sql_runner.execute_update_sql
  end

  xit '' do 
    expect{@db.execute("")}.to_not raise_exception
  end
end