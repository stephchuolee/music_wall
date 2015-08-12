# Homepage (Root path)
helpers do 

  def current_user
    # who is logged in
    @current_user = User.find(session[:id]) if session[:id]
  end 

  def get_user(email, password) 
    user = User.find_by(email: email)

    if user && user.password == password
      session[:email] = user.email
      session[:id] = user.id 
      user
    end
  end 

  def render_track(track_id, messages = nil)
    # the following mimics get '/tracks/:id' 
    @track = Track.find(track_id)
    @tracks = Track.all
    @reviews = Review.where(track_id: track_id)
    @user = current_user
    @messages = messages
    erb :'tracks/show'
  end

  def can_delete?(review_id)
    user = current_user 
    if user
      !!user.reviews.find(review_id)
    end
  end

end 

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
  render_track(params[:id])
end 

get '/login' do 
  erb :'/login'
end 

post '/login' do 
  @user = get_user(params[:email], params[:password])
  
  if !@user.nil?
    redirect '/'
  else
    @messages = ['Invalid login credentials']
    erb :'/login'
  end

end 

get '/logout' do
  session.clear 
  # alternate method:
  # session.delete(:email)
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

post '/add_review' do
  @review = Review.new(
    title: params[:title],
    content: params[:content], 
    user_id: session[:id],
    track_id: params[:track_id] #references name 
    )
  if @review.save 
    redirect "/tracks/#{params[:track_id]}" 
  else 
    render_track(params[:track_id], @review.errors.full_messages)
  end 
end 

get '/delete_review/:review_id' do
  if can_delete?(params[:review_id])
    begin
      review = Review.find(params[:review_id])
      review.delete
      if review.save 
        redirect "/tracks/#{review.track_id}"
      else 
        render_track(params[:review_id], review.errors.full_messages)
      end 
    rescue #find throws error, skips everything up until rescue
      redirect '/tracks'
    end
  else
    redirect '/tracks'
  end
end 


 
