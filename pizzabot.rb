require 'pry'
# Changed the input to a command line arugment.
# I think this is more a long the lines what the
# challenge was asking for
command = ARGV[0]

# the command comes in as a string. I then pass a regex
# expression to the String match method, which will return
# any digits seperated by an x
grid_size_string = command[/\d[x]\d/]

# I use another regex with the scan method to return
# an array everything surrounded by "()"
coordinates = command.scan(/\(.*?\)/)

# I take the array of coordinates that I get and use the
# map method to return a new array with parentheses removed
formatted_coordinates = coordinates.map { |i| i.gsub(/[^\d,\.]/, '') }


