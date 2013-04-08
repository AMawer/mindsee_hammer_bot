require 'socket'
require 'json'
require 'watir-webdriver'

browser = Watir::Browser.new :chrome
browser.goto("http://localhost:3000")

s = TCPSocket.open("127.0.0.1", 13854)
hash = {'format' => 'Json'}
json = hash.to_json
s.write(json)
forward = true
until s.eof?
	line = s.gets("\r")
	hash = JSON.parse(line)
	if hash["blinkStrength"]
		if hash["blinkStrength"] #> 50
			#hash["blinkStrength"]
			if forward 
				browser.div(:class, "up").click
				forward = !forward
				# puts forward
			else
				browser.div(:class, "stop").click
				forward = !forward
				# puts forward
			end
		end
	end
end
s.close