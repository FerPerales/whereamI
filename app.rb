require 'sinatra'
require 'simple-rss'
require 'open-uri'
require 'haml'

get '/' do
  @checkins = get_checkins
  haml :index 
end

not_found do
  haml :not_found
end

:private

def get_checkins(total = 5)
  rss = SimpleRSS.parse open("#{ENV['FOURSQUARE_FEED_URL']}?count=#{total}")
  
  entries = []
  rss.entries.each do |entry|
    entries << entry
  end
  puts " >>>>>>>>>> #{entries.class}"
  entries
end

helpers do

  def distance_of_time_in_words(seconds)
    seconds = (Time.now - seconds).to_i
    minutes = 0
    hours = 0
    days = 0
    phrase = "Recibi #{seconds} segundos"
    # phrase = "sabe"
    if seconds > 0 && seconds <= 60
      phrase = 'menos de un minuto'
    end
    if seconds > 60
      minutes = seconds / 60
      phrase = "hace #{minutes} minutos"
    end
    if minutes && minutes > 60
      hours = minutes / 60

      phrase = "hace #{hours} #{hours > 1 ? 'horas' : 'hora'}"
    end
    if hours && hours > 24
      days = hours / 24
      phrase = "hace #{days} #{days > 1 ? 'días' : 'día'}"
    end    
    if days && days > 365
      years = days / 365
      phrase = "hace #{years} #{years > 1 ? 'años' : 'año'}"
    end
    phrase
  end

end