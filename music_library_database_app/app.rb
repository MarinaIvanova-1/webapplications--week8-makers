# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

def reset_database_tables
  seed_sql = File.read('spec/seeds/albums_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
  seed_sql = File.read('spec/seeds/artists_seeds.sql')
  connection.exec(seed_sql)
end


class Application < Sinatra::Base
  before(:each) do
    reset_database_tables
  end

  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all
    return erb(:albums)
  end

  post '/albums' do
    if invalid_request_parameters?
      status 400
      return ''
    end
    @album = Album.new
    @album.title = params[:title]
    @album.release_year = params[:release_year]
    @album.artist_id = params[:artist_id]
    repo = AlbumRepository.new
    repo.create(@album)

    return ''
  end

  get '/albums/:id' do
    repo = AlbumRepository.new
    repo_artist = ArtistRepository.new
    @album = repo.find(params[:id])
    @artist = repo_artist.find(@album.artist_id)
    return erb(:album)
  end

  get '/artists/:id' do
    repo = ArtistRepository.new
    @artist = repo.find(params[:id])
    
    return erb(:artist)
  end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all

    return erb(:artists)
  end

  get '/new-album' do
    return erb(:new_album)
  end

  def invalid_request_parameters?
    return (params[:title] == nil || params[:release_year] == nil || params[:artist_id] == nil)
  end
end

