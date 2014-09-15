require_relative 'environment'

class SQLRunner
  def initialize(db)
    @db = db
  end

  def execute_schema_sql
    sql = File.read("lib/schema.sql")
    execute_sql(sql)
  end

  def execute_insert_sql
    sql = File.read("lib/insert.sql")
    execute_sql(sql)
  end

  def execute_update_sql
    sql = File.read("lib/update.sql")
    execute_sql(sql)
  end

  def execute_encoded_data
    encoded_data = ""
    decoded_data = Base64.decode64(encoded_data)
    sql = File.open('lib/decoded_data.sql', 'w'){ |f| f.write (decoded_data) }
    sql = File.read('lib/decoded_data.sql')
    execute_sql(sql)
  end

  def execute_sql(sql)
     sql.scan(/[^;]*;/m).each { |line| @db.execute(line) } unless sql.empty?
  end
end