require 'watir'
require 'nokogiri'
require 'nikkou'
require 'csv'
require 'pry'

def read_csv
  array = []
  CSV.foreach("plates.csv") { |row| array.push(row.first) }
  array
end

plate_array = read_csv

CSV.open("out-4.csv", "wb", :write_headers => true, :headers => ["Plate Number","Make","Model", "Year"]) do |csv|
  plate_array.each do |plate|
    url = "https://www.faxvin.com/license-plate-lookup/result?plate=#{plate}&state=CT"
    puts url
    browser = Watir::Browser.new
    browser.goto url

    browser.wait_until(timeout: 15) do |browser|
      sleep 15
      if browser.url != "https://www.faxvin.com/license-plate-lookup?error"
        parsed_content = Nokogiri::HTML(browser.html)

        make = parsed_content.search('b')[1].text
        model = parsed_content.search('b')[2].text
        year = parsed_content.search('b')[3].text

        csv << [plate, make, model, year]

        puts "Plate Number: #{plate}"
        puts "Make: #{make}"
        puts "Model: #{model}"
        puts "Year: #{year}"
        puts "-------------------------------"
        puts ""
      else
        puts "Page not found"
        puts "-------------------------------"
        puts ""
      end
      browser.close
    end
  end
end



