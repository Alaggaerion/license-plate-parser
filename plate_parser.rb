require 'watir'
require 'nokogiri'
require 'nikkou'
require 'csv'
require 'pry'

class Parser
  attr_reader :csv_file, :state
  attr_accessor :plate_array
  
  def initialize(csv_file, state)
    @csv_file = csv_file
    @state = state
    @plate_array = []
  end
  
  def read_csv
    @plate_array = []
    CSV.foreach(@csv_file) { |row| @plate_array.push(row.first) }
  end
  
  def write_csv
    CSV.open("output.csv", "wb", :write_headers => true, :headers => ["Plate Number","Make","Model", "Year"]) do |csv|
      @plate_array.each do |plate|
        url = "https://www.faxvin.com/license-plate-lookup/result?plate=#{plate}&state=CT"
        browser = Watir::Browser.new
        browser.goto url

        browser.wait_until(timeout: 15) do |browser|
          puts ""
          puts "WAITING 15 SECONDS FOR WEBSITE TO FULLY LOAD..."
          sleep 15
          if browser.url != "https://www.faxvin.com/license-plate-lookup?error"
            parsed_content = Nokogiri::HTML(browser.html)

            make = parsed_content.search('b')[1].text
            model = parsed_content.search('b')[2].text
            year = parsed_content.search('b')[3].text

            csv << [plate, make, model, year]

            puts "-------------------------------------------------------------------------------"
            puts "URL: #{url}"
            puts "Plate Number: #{plate}"
            puts "Make: #{make}"
            puts "Model: #{model}"
            puts "Year: #{year}"
            puts "-------------------------------------------------------------------------------"
            puts ""
          else
            puts "-------------------------------------------------------------------------------"
            puts "URL: #{url}"
            puts "Plate Number: #{plate}"
            puts "PLATE NOT FOUND"
            puts "-------------------------------------------------------------------------------"
            puts ""
          end
          browser.close
        end
      end
    end
  end
  
end

def execute
  parser = Parser.new("plates.csv", "CT")
  parser.read_csv
  parser.write_csv
end

execute






