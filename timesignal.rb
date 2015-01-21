require 'uri'
require 'net/http'

def submit(params)
  uri = URI::HTTPS.build(:host => "slack.com", :path => "/api/chat.postMessage")
  uri.query =  URI.encode_www_form(params)
  Net::HTTP.get(uri)
end

def countdown
  now = Time.now
  min = 59 - now.min      
  sec = 60 - now.sec
  sleep 60 * min + sec
end

def alert_time
  alert_time = Time.now.hour.modulo(24)      
end

host = 'USERNAME'
token = 'TOKEN'
channel = "CHANNEL"
params = {
  :token => token,
  :channel => channel,
  :username => host,
}

countdown

loop {
  puts "It's #{Time.now} now !"
  params[:text] = "It's #{alert_time} o'clock now !"
  submit(params)
  countdown
}
