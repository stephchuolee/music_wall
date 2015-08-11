# Homepage (Root path)

configure do 
  enable :sessions
end 

get '/' do
  erb :index
end

get '/tracks' do 
  @tracks = Track.includes(:votes).group("tracks.id").order("count(votes.id) desc").references(:votes)
  erb :'tracks/index'
  # erb :'tracks/index'
end 

post '/upvote' do 
  @vote = Vote.create(
    track_id: params[:track_id],
    user_id: session[:id]
    )
  unless @vote.valid? 
    @tracks = Track.all # required to render tracks/index
    erb :'tracks/index'
  else 
    redirect '/tracks'
  end 

end 

get '/tracks/new' do
  erb :'tracks/new'
end

post '/tracks' do 
  @track = Track.new(
    title: params[:title],
    artist: params[:artist],
    url: params[:url],
    user_id: session[:id]
    )
  if @track.save 
    redirect '/tracks'
  else
    erb :'tracks/new'
  end 
end 

get '/tracks/:id' do 
  @track = Track.find params[:id]
  @tracks = Track.all
  erb :'tracks/show'
end 

get '/login' do 
  erb :'/login'
end 

post '/login' do 
  @user = User.find_by(email: params[:email])

  if @user && @user.password == params[:password]
    session[:email] = @user.email
    session[:id] = @user.id 
    redirect '/'
  else
    @messages = ['Invalid login credentials']
    erb :'/login'
  end

end 

get '/logout' do
  session.delete(:email)
  redirect '/'
end 

get '/signup' do 
  erb :'/signup'
end 

post '/signup' do 
  @user = User.create(
    email: params[:email],
    password: params[:password],
    )
  redirect '/'
end 


    



  # all songs belong to a user
  # users can only up/downvote when if there is a session running
  # logout destroys the session



