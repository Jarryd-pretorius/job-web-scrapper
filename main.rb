require 'HTTParty'
require 'Nokogiri'
require 'byebug'

puts "--------------------------------------"
puts "hello welcome to house Data!"
puts "--------------------------------------"

    class Scraper 
           
            puts ""
            puts ""
            puts "- - - - what State are you looking for? - - - -"
            stateName = gets.chomp
            puts "- - - - Please Enter a suburb - - - -"
            suburb = gets.chomp
            puts "- - - - Please Enter a postcode - - - -"
            postCode = gets.chomp
            puts " - - - Finding results for: #{suburb}, #{stateName} - #{postCode} - - -"
            


            url = "https://www.domain.com.au/sale/#{suburb}-#{stateName}-#{postCode}/"
            doc = HTTParty.get(url)
            parse_page = Nokogiri::HTML(doc)
            houses = Array.new
            houseListings = parse_page.css("ul[data-testid='results']").css("li")
            numberListings = parse_page.css("h1[data-testid='summary']").css("strong").text
            per_page = houseListings.count
            page =  1
            last_page = (numberListings.to_f / per_page.to_f).round
            while page <= last_page 
                    fullSearch_url = "https://www.domain.com.au/sale/#{suburb}-#{stateName}-#{postCode}/house/?excludeunderoffer=1&page=#{page}"
                    fullSearch_doc = HTTParty.get(fullSearch_url)
                    fullSearch_parse_page = Nokogiri::HTML(fullSearch_doc)
                    puts ""
                    puts " - - - - #{numberListings} found! - - - -"
                    puts ""
                   
                    puts "- - - would you like to see some house listings (Y/N)? - - -"
                    see_house = gets.chomp
                    if see_house != "Y" && see_house != "N" 
                        puts "- - - - Please enter captial Y for yes or N for no - - - -"
                        see_house = gets.chomp
                    end
                    if see_house == "N"
                        puts "- - - Would you like to restart Search? (Y/N) - - -"
                        restart_search == gets.chomp
                        if restart_search == "Y"
                        load 'main.rb'
                        end
                    end 
                    

                    puts "- - how many house lisitings out of: #{numberListings} would you like to see? - -"
                    numberListings = gets.chomp.to_f
                    full_houseListings = fullSearch_parse_page.css("ul[data-testid='results']").css("li")
                    full_houseListings.each do |full_houseListings|
                        house = {
                            address1: full_houseListings.css("span[data-testid='address-line1']").text,
                            address2: full_houseListings.css("span[data-testid='address-line2']").text,
                            beds: full_houseListings.css("span[data-testid='property-features-text-container']").text.split[0] ,
                            baths: full_houseListings.css("span[data-testid='property-features-text-container']").text.split[2],
                            price: full_houseListings.css("p[data-testid='listing-card-price']").text
                            
                        }
                        houses << house
                        puts "#{house[:address1]}: #{house[:address2]}"
                        puts" -------------------"
                        puts " #{house[:price]}"
                        puts ""
                        puts "Beds #{house[:beds]} #{house[:baths]}"
                        puts " __________________________________________"
                        puts ""
                    end
                page += 1
                
            

            end
            numberListings = parse_page.css("h1[data-testid='summary']").css("strong").text
            load"main.rb"
    end

