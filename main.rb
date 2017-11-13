require 'sinatra'
require 'sinatra/reloader'
require 'sass'
require './student'
require 'date'

#get("/styles.css") do
#	scss :"styles"
#end

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

get '/students/new' do
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
		:birthday => Date::strptime(params['birthday'],'%m/%d/%y'),
		:address => params['address'],
		:score => params['score']
	)
	redirect ('/students/' + @student.id.to_s)
	
end

get'students/:id/edit' do
	@student = Student.get(params[:id])
	puts(@studnet.first_name, @student.score)
	erb :edit_students
end

delete 'students/:id' do
	Student.get(params[:id]).destroy
	redirect ('/students/')

end 
