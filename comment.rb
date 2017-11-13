require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/comment.db")

class Comment
	include DataMapper::Resource
	property :id, Serial
	property :name, String
	property :content, Text
	property :time_created, DateTime
end

configure do
  enable :sessions
  set :username, 'admin'
  set :password, 'admin'
end

# then call 
DataMapper.finalize

DataMapper.auto_upgrade!





