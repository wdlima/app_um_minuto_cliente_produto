Thread.new do
  loop do
    sleep 120 # 2 minutos
    puts "::: Heroku wake up :::"
    request = HTTParty.get(URI.escape(ENV["HOST"] || "http://www.personalnapratica.com.br/"))
    puts "::: Access done :::"
  end
end
