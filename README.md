# license-plate-parser

## About this Parser

A little while ago my friend contacted me and said he was involved in a hit and run. Even though the driver got away, my friend was able to grab a couple of licence plate numbers. On top of that he was able determine the Make, Model, and Year of the car. The question he asked was if he gave me a generated list of licence plate numbers, if I could create an automation task to help him figure out what kind of cars the generated licence plate would return. For that solution I created this Licence Plate Parser.

## How does it work

After downloading the repo onto your desktop, open your terminal and navigate into the folder. Once there: 

* Open `plates.csv` file.

Inside the file paste all the licence plate numbers you want to parse through.

Next inside terminal run the following command:

* `ruby plate_parser.rb`

Once the script fininshes running and new file will be created:

* `output.csv`
