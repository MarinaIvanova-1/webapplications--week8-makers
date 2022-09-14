require 'spec_helper'
require 'rack/test'
require_relative '../../app'

describe Application do
  include Rack::Test::Methods

  let(:app) {Application.new}

  context 'GET /' do
    it 'returns the html list of names' do
      response = get('/')


      expect(response.body).to include ('<p>Anna</p>')
      expect(response.body).to include ('<p>Kim</p>')
      expect(response.body).to include ('<p>Josh</p>')
      expect(response.body).to include ('<p>David</p>')
    end
  end

  context 'GET /password' do
    it 'returns a hello page is the password is correct' do
      response = get('/password', password: 'abcd')

      expect(response.body).to include("Hello!")
    end

    it 'returns a forbidden page is the password is incorrect' do
      response = get('/password', password: 'abasdasdcd')

      expect(response.body).to include("Access forbidden")
    end
  end

  context 'POST /' do
    it 'returns 200 OK' do
      response = post('/', name: 'Marina', cohort_name: 'August')

      expect(response.status).to eq(200)
    end
  end

  context 'GET /hello' do
    it 'should return "Hello!"' do
      response = get('/hello')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Hello!</h1>')
    end

  end

  context 'POST /sort-names' do
    it 'should return "Alice,Joe,Julia,Kieran,Zoe"' do
      response = post('/sort-names?names=Joe,Alice,Zoe,Julia,Kieran')

      expect(response.status).to eq(200)
      expect(response.body).to eq("Alice,Joe,Julia,Kieran,Zoe")
    end
  end

  context "GET /names" do
    it 'returns a string of names' do

      response = get('/names?name=Julia, Mary, Karim')

      expect(response.status).to eq(200)
      expect(response.body).to eq('Julia, Mary, Karim')
    end
  end
end