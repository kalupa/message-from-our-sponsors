%w(rubygems sinatra compass haml ./lib/mfos sinatra/jsonp json).each { |lib| require lib }

set :haml, { :format => :html5 }

include Mfos

helpers do
  def versioned_css(stylesheet)
    "/stylesheets/#{stylesheet}.css?" + File.mtime(File.join(Sinatra::Application.views, "stylesheets", "#{stylesheet}.sass")).to_i.to_s
  end
  
  def versioned_js(js)
    "/javascripts/#{js}.js?" + File.mtime(File.join(Sinatra::Application.public, "javascripts", "#{js}.js")).to_i.to_s
  end
end

get "/stylesheets/main.css" do
  content_type 'text/css'
  response['Expires'] = (Time.now + 60*60*24*356*3).httpdate
  sass :"stylesheets/main"
end

get '/' do
  haml :index
end

get '/pong' do
  content_type :json
  JSONP :result => generate_response
end

get '/generate' do
  @result = generate_text(params)
  content_type :json
  if @result
    JSONP :result => "<p>Single Mom Learns One Simple Trick to Whiten Teeth</p>"
  else
    JSONP :result => "<p>Cow Discovers How to Fly Airplane</p>"
  end
end