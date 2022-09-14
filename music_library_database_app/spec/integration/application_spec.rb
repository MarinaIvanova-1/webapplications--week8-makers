require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context 'GET /albums' do
    it 'should return the list of albums' do
      response = get('/albums')

      expect(response.status).to eq(200)
      expect(response.body).to include('Title: <a href=/albums/4>Super Trouper</a')
    end
  end

  context 'POST /albums' do
    it 'should create a new album' do
      response = post(
        '/albums', 
        title: 'Voyage', 
        release_year: '2022',
        artist_id: '2'
        )
      all_albums = get('/albums')

      expect(response.status).to eq(200)
      expect(response.body).to eq('')
      expect(all_albums.body).to include('Voyage')
    end
  end

  context 'GET /albums/:id' do
    it 'should return the title, release year and an artist of a given album' do
      response = get('/albums/2')
      expect(response.status).to eq (200)
      expect(response.body).to include("<h1>Surfer Rosa</h1>")
      expect(response.body).to include("Release year: 1988")
      expect(response.body).to include("Artist: Pixies")                                  
    end
  end

  context 'GET/artists/:id' do
    it 'returns information about a given artist' do
      response = get('/artists/1')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Pixies</h1>')
      expect(response.body).to include('Genre: Rock')
    end
  end

  context "GET /artists" do
    it 'returns a list of artists' do

      response = get('/artists')

      expect(response.status).to eq(200)
      expect(response.body).to include('<a href=/artists/1><p>Pixies</p></a>')
      expect(response.body).to include('<p>Pixies</p>')
      expect(response.body).to include('<a href=/artists/2><p>ABBA</p></a>')
      expect(response.body).to include('<p>ABBA</p>')
      expect(response.body).to include('<a href=/artists/3><p>Taylor Swift</p></a>')
      expect(response.body).to include('<p>Taylor Swift</p>')
    end
  end
end
