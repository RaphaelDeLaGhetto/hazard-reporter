
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





