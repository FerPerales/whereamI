require 'sinatra'
require 'simple-rss'
require 'open-uri'
require 'haml'

not_found do
  haml :not_found
end