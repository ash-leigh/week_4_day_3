require( 'pry-byebug' )
require_relative('../db/sql_runner')

class Artist
  attr_reader(:name, :id)

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i
  end

  def save()
    sql = "INSERT INTO artists (name) VALUES ('#{@name}') RETURNING *"
    artist_data = run_sql(sql)
    @id = artist_data.first['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM artists"
    artists = run_sql(sql)
    result = artists.map{|artist| Artist.new(artist)}
    return result
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = #{@id}"
    albums_data = run_sql( sql )
    albums = albums_data.map { |album_data| Album.new(album_data) }
    return albums
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = #{id}"
       artist = run_sql(sql)
       result = Artist.new(artist.first)
       return result
  end

  def self.destroy(id)
    sql= "DELETE FROM artists WHERE id = #{id}"
    run_sql(sql)
  end

  def self.update(options)
    sql = "UPDATE artists SET
           name= '#{options['name']}'
           WHERE id = '#{options['id']}'"
       
    run_sql(sql)
  end

  def self.search(name)
    sql = "SELECT * FROM artists WHERE name = '#{name}'"
    artists = run_sql(sql)
    results = artists.map{|artist| Artist.new(artist)}
    return results
  end
end
