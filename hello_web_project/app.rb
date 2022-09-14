require 'sinatra/base'

class Application < Sinatra::Base

  get '/' do
    @name = ['Anna', 'Kim', 'Josh', 'David']
    return erb(:index)
  end

  get '/password' do
    @password = params[:password]
    return erb(:password)
  end

  post '/' do
  end

  post '/sort-names' do
    names = params[:names]
    return sorted_names = names.split(',').sort.join(',')
  end

  get '/posts' do
    name = params[:name]
    cohort_name = params[:cohort_name]

    return "Hello #{name}, you are in the #{cohort_name} cohort"
  end

  get '/hello' do
    return erb(:hello)
  end

  post '/posts' do
    title = params[:title]
    
    return "Post was created with title: #{title}"
  end

  post '/submit' do
    name = params[:name]
    message = params[:message]
    return "Thanks #{name}, you sent this message: #{message}"
  end

  get '/names' do
    name = params[:name]
    return "#{name}"
  end
end