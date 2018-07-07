require 'pry'

# ******** RULES ***********
# assertEqual(pizzabot("5x5 (1, 3) (4, 4)"), "ENNNDEEEND")



# Changed the input to a command line arugment.
# I think this is more a long the lines what the
# challenge was asking for
command = ARGV[0]

# given the command line prompt ruby pizzabot.rb "5x5 (1, 3) (4, 4) (2,1)"
# command will return:
# "5x5 (1, 3) (4, 4) (2,1)"



# the command comes in as a string. I then pass a regex
# expression to the String match method, which will return
# any digits seperated by an x
grid_size_string = command[/\d[x]\d/]

# -> "5x5"

# I use another regex with the scan method to return
# an array everything surrounded by "()"
coordinates_array = command.scan(/\(.*?\)/)

# -> ["(1, 3)", "(4, 4)", "(2,1)"]


# This method takes coodinates and returns a Hash object.
# The Hash object will have a key of x_axis and y_axis assigned
def format_coordinates(coordinates)
  # coordinates -> "(1, 3)"

  # take the coordinates and remove the parentheses, then split
  # them into an array on the comma. Then convert them to integers.
  coordinates = coordinates
                .gsub(/[^\d,\.]/, '')
                .split(',')
                .map{ |x| x.to_i }
  # -> [1, 3]

  {
    x_axis: coordinates.first,
    y_axis: coordinates.last
  }
end


# I take the coordinates_array and run each coordinate through
# the format_coordinates method. The resulting Hash object is then
# passed to an array that gets assigned to the variable (formatted_coordinates)
formatted_coordinates = coordinates_array.map do |coords|
  format_coordinates(coords)
end

# -> [{:x_axis=>1, :y_axis=>3}, {:x_axis=>4, :y_axis=>4}, {:x_axis=>2, :y_axis=>1}]


