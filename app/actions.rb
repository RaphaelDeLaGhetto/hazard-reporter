
get '/' do
   
    @hazards = Hazard.all
    erb :index
end