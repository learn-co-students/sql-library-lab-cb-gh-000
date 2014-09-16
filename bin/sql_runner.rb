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

    encoded_data = "SU5TRVJUIElOVE8gc2VyaWVzIChpZCwgdGl0bGUsIGF1dGhvcl9pZCwgc3Vi\nZ2VucmVfaWQpIFZBTFVFUyAoMSwgIkEgU29uZyBvZiBJY2UgYW5kIEZpcmUi\nLCAxLCAxKSwgKDIsICJTZWNvbmQgU2VyaWVzIiwgMiwgMik7CklOU0VSVCBJ\nTlRPIHN1YmdlbnJlcyAoaWQsIG5hbWUpIFZBTFVFUyAoMSwgIm1lZGlldmFs\nIiksICgyLCAic3BhY2Ugb3BlcmEiKTsKSU5TRVJUIElOVE8gYXV0aG9ycyAo\naWQsIG5hbWUpIFZBTFVFUyAoMSwgIkdlb3JnZSBSLiBSLiBNYXJ0aW4iKSwg\nKDIsICJTZWNvbmQgQXV0aG9yIik7CklOU0VSVCBJTlRPIGJvb2tzIChpZCwg\ndGl0bGUsIHllYXIsIHNlcmllc19pZCkgVkFMVUVTICgxLCAiR2FtZSBvZiBU\naHJvbmVzIiwgMTk5NiwgMSksICgyLCAiQSBDbGFzaCBvZiBLaW5ncyIsIDE5\nOTgsIDEpLCAoMywgIkEgU3Rvcm0gb2YgU3dvcmRzIiwgMjAwMCwgMSksICg0\nLCAiRmlyc3QgQm9vayIsIDIwMDIsIDIpLCAoNSwgIlNlY29uZCBCb29rIiwg\nMjAwMywgMiksICg2LCAiVGhpcmQgQm9vayIsIDIwMDUsIDIpOwpJTlNFUlQg\nSU5UTyBjaGFyYWN0ZXJzIChpZCwgbmFtZSwgbW90dG8sIHNwZWNpZXMsIGF1\ndGhvcl9pZCwgc2VyaWVzX2lkKSBWQUxVRVMgKDEsICJMYWR5IiwgIldvb2Yg\nV29vZiIsICJkaXJld29sZiIsIDEsIDEpLCAoMiwgIlR5cmlvbiBMYW5pc3Rl\nciIsICJBIExhbmlzdGVyIGFsd2F5cyBwYXlzIGlzIGRlYnRzIiwgImh1bWFu\nIiwgMSwgMSksICgzLCAiRGFlbmVyeXMgVGFyZ2FyeWVuIiwgIklmIEkgbG9v\nayBiYWNrIEkgYW0gbG9zdCIsICJodW1hbiIsIDEsIDEpLCAoNCwgIkVkZGFy\nZCBTdGFyayIsICJXaW50ZXIgaXMgY29taW5nIiwgImh1bWFuIiwgMSwgMSk7\nCklOU0VSVCBJTlRPIGNoYXJhY3RlcnMgKGlkLCBuYW1lLCBtb3R0bywgc3Bl\nY2llcywgYXV0aG9yX2lkLCBzZXJpZXNfaWQpIFZBTFVFUyAoNSwgIkNoYXJh\nY3RlciBPbmUiLCAibW90dG8gb25lIiwgImN5bG9uIiwgMiwgMiksICg2LCAi\nQ2hhcmFjdGVyIFR3byIsICJtb3R0byB0d28iLCAiaHVtYW4iLCAyLCAyKSwg\nKDcsICJDaGFyYWN0ZXIgVGhyZWUiLCAibW90dG8gdGhyZWUiLCAiY3lsb24i\nLCAyLCAyKSwgKDgsICJDaGFyYWN0ZXIgRm91ciIsICJtb3R0byBmb3VyIiwg\nImN5bG9uIiwgMiwgMik7CklOU0VSVCBJTlRPIGNoYXJhY3Rlcl9ib29rIChp\nZCwgYm9va19pZCwgY2hhcmFjdGVyX2lkKSBWQUxVRVMgKDEsIDEsIDEpLCAo\nMiwgMSwgMiksICgzLCAyLCAyKSwgKDQsIDMsIDIpLCAoNSwgMSwgMyksICg2\nLCAyLCAzKSwgKDcsIDMsIDMpLCAoOCwgMSwgNCk7CklOU0VSVCBJTlRPIGNo\nYXJhY3Rlcl9ib29rIChpZCwgYm9va19pZCwgY2hhcmFjdGVyX2lkKSBWQUxV\nRVMgKDksIDQsIDUpLCAoMTAsIDQsIDYpLCAoMTEsIDUsIDYpLCAoMTIsIDYs\nIDYpLCAoMTMsIDQsIDcpLCAoMTQsIDUsIDcpLCAoMTUsIDYsIDcpLCAoMTYs\nIDQsIDgpOw==\n"
    decoded_data = Base64.decode64(encoded_data)
    sql = File.open('lib/decoded_data.sql', 'w'){ |f| f.write (decoded_data) }
    sql = File.read('lib/decoded_data.sql')
    execute_sql(sql)
  end

  def execute_sql(sql)
     sql.scan(/[^;]*;/m).each { |line| @db.execute(line) } unless sql.empty?
  end
end