require 'watir'
require 'webdrivers'
require 'nokogiri'

puts "--------------------------------------"
puts "hello welcome to job skill Searcher!"
puts "--------------------------------------"

puts "what job are you searching for today?"
job = gets.chomp

puts "skills required for: " + job

url = "https://a-z-animals.com/animals/beetle/"
uri = URI.parse(url)
response = Net::HTTP.get_response(uri)
require 'json'
JSON.parse(response.body)
puts response.body
