
get '/' do
    sinkhole = {
        description: "Sinkhole",
        image: "https://cbsdenver.files.wordpress.com/2017/07/loveland-sinkhole.jpg?w=1500",
        coordinates: '51.13459777777778,-114.15988158333333',
        date_reported: Date.today
   }
   
   powerlines = {
        description: 'Downed power line',
        image: 'https://www.hsi.com/hubfs/Blog_Images/Header_Images/DownedPowerLines.jpg',
        coordinates: '51.154060361111114,-114.16134641666667',
        date_reported: Date.today.prev_day
   }
    
   debris = {
        description: 'Falling debris hazard',
        image: 'http://www.thevanguard.ca/content/dam/tc/the-vanguard/images/2016/3/20/broken-turbine-3051062.jpg',
        coordinates: '51.1480255,-114.2352218611111',
        date_reported: Date.today.prev_day.prev_day.prev_day.prev_day.prev_day.prev_day.prev_day.prev_day.prev_day.prev_day.prev_day.prev_day
    } 
    
    @hazards = [sinkhole, powerlines, debris]
    erb :index
end