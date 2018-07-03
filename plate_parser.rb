require 'watir'
require 'nokogiri'
require 'nikkou'
require 'csv'
require 'pry'

plate_array = [
"AL58815","AL58819","AL93313","AL93315","AL93319","AL93513","AL93515","AL93519","AL93613","AL93615","AL93619","AL93813","AL93815","AL93819","AL95313","AL95315","AL95319","AL95513","AL95515","AL95519","AL95613","AL95615","AL95619","AL95813","AL95815","AL95819","AL96313","AL96315","AL96319","AL96513","AL96515","AL96519","AL96613","AL96615","AL96619","AL96813","AL96815","AL96819","AL98313","AL98315","AL98319","AL98513","AL98515","AL98519","AL98613","AL98615","AL98619","AL98813","AL98815","AL98819","AT33313","AT33315","AT33319","AT33513","AT33515","AT33519","AT33613","AT33615","AT33619","AT33813","AT33815","AT33819","AT35313","AT35315","AT35319","AT35513","AT35515","AT35519","AT35613","AT35615","AT35619","AT35813","AT35815","AT35819","AT36313","AT36315","AT36319","AT36513","AT36515","AT36519","AT36613","AT36615","AT36619","AT36813","AT36815","AT36819","AT38313","AT38315","AT38319","AT38513","AT38515","AT38519","AT38613","AT38615","AT38619","AT38813","AT38815","AT38819","AT53313","AT53315","AT53319","AT53513","AT53515","AT53519","AT53613","AT53615","AT53619","AT53813","AT53815","AT53819","AT55313","AT55315","AT55319","AT55513","AT55515","AT55519","AT55613","AT55615","AT55619","AT55813","AT55815","AT55819","AT56313","AT56315","AT56319","AT56513","AT56515","AT56519","AT56613","AT56615","AT56619","AT56813","AT56815","AT56819","AT58313","AT58315","AT58319","AT58513","AT58515","AT58519","AT58613","AT58615","AT58619","AT58813","AT58815","AT58819","AT93313","AT93315","AT93319","AT93513","AT93515","AT93519","AT93613","AT93615","AT93619","AT93813","AT93815","AT93819","AT95313","AT95315","AT95319","AT95513","AT95515","AT95519","AT95613","AT95615","AT95619","AT95813","AT95815","AT95819","AT96313","AT96315","AT96319","AT96513","AT96515","AT96519","AT96613","AT96615","AT96619","AT96813","AT96815","AT96819","AT98313","AT98315","AT98319","AT98513","AT98515","AT98519","AT98613","AT98615","AT98619","AT98813","AT98815","AT98819"
]

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



