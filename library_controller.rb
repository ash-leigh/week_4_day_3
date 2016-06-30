require('sinatra')
require('sinatra/contrib/all')
require_relative('./models/artist')
require_relative('./models/album')
require_relative('./controllers/artist_controller')
require_relative('./controllers/album_controller')

get '/library' do
  @albums = Album.all()
  erb(:'library/index')
end

get '/search' do
  @artists = Artist.all()
  @albums = Album.all()
  erb(:'library/search')
end