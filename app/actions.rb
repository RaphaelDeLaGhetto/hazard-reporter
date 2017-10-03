
helpers do
    def logged_in?
       !session[:user_id].nil? 
    end
end

get '/' do
    @hazards = Hazard.all
    erb :index
end

#
# /signup
#
get '/signup' do
   @user = User.new
   erb :signup
end

post '/signup' do
    @user = User.new({ email: params[:email],
                       password: params[:password] })
                        
    if @user.save
        redirect '/'
    else
        erb :signup
    end
end

#
# login
#
get '/login' do
  @user = User.new
  erb :login
end

post '/login' do
  @user = User.find_by_email(params[:email])
  if @user.password == params[:password]
      session[:user_id] = @user.id
      redirect '/'
  else
      erb :login
  end
end

get '/logout' do
  #session[:user_id] = nil
  session.clear
  redirect '/'
end