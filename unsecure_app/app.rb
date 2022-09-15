require 'sinatra/base'
require "sinatra/reloader"

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  post '/hello' do
    @name = params[:name]
    # special = "?<>',?[]}{=)(*&^%$#`~{}"
    # regex = /[#{special.gsub(/./){|char| "\\#{char}"}}]/
    # if @name =~ regex
    #   return erb(:error)
    # else
      return erb(:hello)
    # end
  end
end
