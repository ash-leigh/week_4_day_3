require( 'pry-byebug' )
require_relative('../db/sql_runner')
require_relative('../models/artist')
require_relative('../models/album')

get '/albums' do
  @albums = Album.all()
  erb(:'albums/index')
end

get '/albums/new' do
  @artists = Artist.all
  erb(:'albums/new')
end

post '/albums' do
  @album = Album.new(params)
  @album.save()
  erb(:'albums/create')
end

get '/albums/:id' do
  @album = Album.find(params[:id])
  erb(:'albums/show')
end

post '/albums/:id/delete' do
  Album.destroy(params[:id])
  redirect to("/albums")
end

get '/albums/:id/edit' do
  @album = Album.find(params[:id])
  @artists = Artist.all()
  erb(:'albums/edit')
end

post '/albums/:id' do
  @album = Album.update(params)
  redirect to("/albums/#{params[:id]}")
end



