require 'sinatra'
require 'sinatra/reloader'
require 'sass'
require './student'
require './comment'
require 'date'

#get("/styles.css") do
#	scss :"styles"
#end

configure do
  enable :sessions
  set :username, 'admin'
  set :password, 'admin'
end

get '/' do 
	@title  = "Home"
	erb :home
end

get '/about' do 
	@title = "About"
	erb :about

end

get '/contact' do 
	@title = "Contact"
	erb :Contact

end

get '/students' do 
	#@title = "Students"
	@students = Student.all
	erb :students

end

get '/comment' do 
	@title = "Comment"
	erb :comment

end

get '/video' do 
	@title = "About"
	erb :about

end

get '/login' do 
	@title = "Login"
	erb :login

end

post "/login" do
	if params["username"] == 'admin' && params['password'] == "admin"
		session[:logged_in] = true
		redirect to ("/")
	else
		erb :login
	end
end

get "/logout" do
	session[:logged_in] = nil
	redirect to ("/")
end

get '/students/new' do
	redirect("/login") unless session[:logged_in]
	@title = "add a new student"
	erb :new_student
end

get '/students/:id' do
	# query the student
	@student = Student.get(params[:id])
	
	erb :show_students
end

post '/students' do
	@student = Student.create(
		:first_name => params['firstname'],
		:last_name => params['lastname'],
		:birthday => Date::strptime(params['birthday'],'%m/%d/%Y'),
		:address => params['address'],
		:score => params['score']
	)
	redirect ('/students/' + @student.id.to_s)	
end

get '/students/:id/edit' do
	redirect("/login") unless session[:logged_in]
	@student = Student.get(params[:id])
	puts(@student.first_name, @student.score)
	erb :edit_students
end

put '/students/:id' do
	@student = Student.get(params[:id])
	@student.update(
		:first_name => params['firstname'],
		:last_name => params['lastname'],
		:birthday => Date::strptime(params['birthday'],'%m/%d/%Y'),
		:address => params['address'],
		:score => params['score']
	)
	puts params['birthday']
	puts Date::strptime(params['birthday'],'%m/%d/%y')
	puts @student.birthday
	redirect ('/students/' + @student.id.to_s)
end

delete '/students/:id' do
	Student.get(params[:id]).destroy
	redirect ('/students')
end 

get '/comments' do
	@comments = Comment.all
	erb :comments
end

get '/comments/new' do
	@title = "add a new comment"
	erb :new_comment
end

post '/comments' do
	@comment = Comment.create(
		:name => params['name'],
		:content => params['comment'],
		:time_created => Time.now
	)
	redirect ('/comments')	
end

get '/comments/:id' do
	# query the comment
	@comment = Comment.get(params[:id])
	erb :show_comment
end