#
# Users
#
danny = User.create({
  name: 'Danny',
  email: 'danny@capitolhill.ca',
  password: 'secret'
})

lanny = User.create({
  name: 'Lanny',
  email: 'lanny@capitolhill.ca',
  password: 'secret' 
})

hazards = [
  {
    description: "Sinkhole",
    image: "https://cbsdenver.files.wordpress.com/2017/07/loveland-sinkhole.jpg?w=1500",
    coordinates: '51.13459777777778,-114.15988158333333',
    user_id: danny.id
  },
  {
    description: 'Downed power line',
    image: 'https://www.hsi.com/hubfs/Blog_Images/Header_Images/DownedPowerLines.jpg',
    coordinates: '51.154060361111114,-114.16134641666667',
    user_id: danny.id
  },
  {
    description: 'Falling debris hazard',
    image: 'http://www.thevanguard.ca/content/dam/tc/the-vanguard/images/2016/3/20/broken-turbine-3051062.jpg',
    coordinates: '51.1480255,-114.2352218611111',
    user_id: lanny.id
  } 
]

hazards.each do |hazard|
  Hazard.create(hazard) 
end