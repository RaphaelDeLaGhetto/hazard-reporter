
helpers do
    def logged_in?
       !session[:user_id].nil? 
    end
end

before do
  if request.path !~ /login/ &&
     request.path !~ /signup/ &&
     request.request_method != 'GET'
     
    halt(401, erb(:error_401)) unless logged_in? 
    
#    if !logged_in? 
#      halt(401, erb(:error_401))
#    end
  end
end

['/hazard/new', '/hazard/:id/edit'].each do |path|
  before path do
    redirect '/login' unless logged_in?
  end
end


get '/' do
    #@hazards = Hazard.all
    @hazards = Hazard.order(created_at: :desc)
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

#
# hazards
#
# Get form to create a new hazard in the database
get '/hazard/new' do
    @hazard = Hazard.new
    erb(:'hazard/new')
end

# Read one hazard from the database
get '/hazard/:id' do
  @hazard = Hazard.find(params[:id]) 
  erb :'hazard/show'
end


# Create a new hazard in the database
post '/hazard' do
  @hazard = Hazard.new
  
  # Set description
  @hazard.description = params[:description]
    
  # Move file into storage
  tempfile = params[:image][:tempfile] 
  filename = params[:image][:filename] 
  filepath = "/uploads/#{filename}"
  @hazard.image = filepath
  filepath = "public#{filepath}"
  FileUtils.cp(tempfile.path, filepath)
  
  # Calculate coords from EXIF rational numbers
  # 2016-11-23 http://stackoverflow.com/questions/18244721/mapping-exif-data-to-long-lat
  if EXIFR::JPEG.new(filepath).exif?
    latitude = EXIFR::JPEG.new(filepath).gps_latitude[0].to_f +
               EXIFR::JPEG.new(filepath).gps_latitude[1].to_f / 60 +
               EXIFR::JPEG.new(filepath).gps_latitude[2].to_f / 3600
    latitude *= -1 if EXIFR::JPEG.new(filepath).gps_latitude_ref == 'S'
    longitude = EXIFR::JPEG.new(filepath).gps_longitude[0].to_f +
                EXIFR::JPEG.new(filepath).gps_longitude[1].to_f / 60 +
                EXIFR::JPEG.new(filepath).gps_longitude[2].to_f / 3600 
    longitude *= -1 if EXIFR::JPEG.new(filepath).gps_longitude_ref == 'W'
    coords = "#{latitude},#{longitude}"
    
    @hazard.coordinates = coords
  end
    
  @hazard.user_id = session[:user_id]
  
  if @hazard.save
    redirect '/'
  else
    erb :'hazard/new'
  end 
end

# Get form to change a hazard in the database
get '/hazard/:id/edit' do
    @hazard = Hazard.find(params[:id]) 
    erb :'hazard/edit'
end

# Change something in the database
put '/hazard/:id' do
  @hazard = Hazard.find(params[:id]) 
  @hazard.description = params[:description]
  if @hazard.save
    redirect("hazard/#{@hazard.id}")
  else
    erb :'hazard/edit'
  end
end

# Remove a hazard from the database
delete '/hazard/:id' do
    Hazard.delete(params[:id])
    redirect('/')
end








