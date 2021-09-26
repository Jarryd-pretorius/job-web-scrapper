require 'watir'
require 'webdrivers'
require 'nokogiri'

puts "--------------------------------------"
puts "hello welcome to job skill Searcher!"
puts "--------------------------------------"

puts "what job are you searching for today?"
job = gets.chomp

puts "skills required for: " + job