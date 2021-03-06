require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/student.db")



class Student
	include DataMapper::Resource
	property :id, Serial
	property :first_name, String
	property :last_name, String
	property :birthday, Date
	property :address, Text
	property :score, Integer
end

configure do
  enable :sessions
  set :username, 'admin'
  set :password, 'admin'
end

# then call 
DataMapper.finalize

DataMapper.auto_upgrade!





