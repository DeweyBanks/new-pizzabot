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


# The starting point is at the coordinates 0, 0. So, I create
# an object that represents that.
starting_location = {:x_axis => 0, :y_axis => 0}

# I will take the first formatted_coordinate to set as the target_location
target_location = formatted_coordinates.first

# I create an empty array to hold the directions
directions = []



# we could get the number of moves North by the difference between this two:
# starting_location[:x_axis] target_location[:x_axis]
# so if SL.x_axis is 0 and TL.x_axis is 1, we need to move North one time

# I set a variable to the difference of the two x_axis points
x_move_number = target_location[:x_axis] - starting_location[:x_axis]
# -> 1
# here, if the number is positive it would be a move North. Negative
# would be move South.

if x_move_number > 0
  # if it's a positive number we push "N" into the directions array
  # times the move_number. So if move_number is 2, we push "N" into
  # directions twice.
  x_move_number.times { directions << "N" }
else
  # here the number is negative. I call .abs method on the number.
  # this gives the absolute value of the number. Which
  # we need to do in order to tell the .times method
  # how many times to push "S"
  x_move_number.abs.times { directions << "S" }
end

puts directions
