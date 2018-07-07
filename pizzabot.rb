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
                .map(&:to_i)
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



# we could get the number of moves East by the difference between this two:
# starting_location[:x_axis] target_location[:x_axis]
# so if SL.x_axis is 0 and TL.x_axis is 1, we need to move East one time

# I set a variable to the difference of the two x_axis points
x_move_number = target_location[:x_axis] - starting_location[:x_axis]
# -> 1
# here, if the number is positive it would be a move East. Negative
# would be move West.

# it would be better if this wasn't an if statment, but for now it works
# if x_move_number > 0
#   # if it's a positive number we push "E" into the directions array
#   # times the move_number. So if move_number is 2, we push "E" into
#   # directions twice.
#   x_move_number.times { directions << "E" }
# else
#   # here the number is negative. I call .abs method on the number.
#   # this returns the absolute value of the number. Which
#   # we need to do in order to tell the .times method
#   # how many times to push "W"
#   x_move_number.abs.times { directions << "W" }
# end

# could be written as:
x_move_number > 0 ? x_move_number.times { directions << "E" } :
                    x_move_number.abs.times { directions << "W" }

# now switch and do the samething for the y_axis
y_move_number = target_location[:y_axis] - starting_location[:y_axis]
# here a positive number would represent a move North
y_move_number > 0 ? y_move_number.times { directions << "N" } :
                    y_move_number.abs.times { directions << "S" }

# after we've done the above we need to drop the pizza
directions << "D"

# so given the coordinates (1,3) the above would result in:
# -> ENNND

# this method takes both cases above and combines them into one method
# after running rubocop, it says the above if then format is better
# so I changed it back https://github.com/rubocop-hq/rubocop

def move(move_number, axes)
  results = []
  d = axes == 'y' ? ["N", "S"] : ["E", "W"]
  if move_number > 0
    move_number.times { results << d.first }
  else
    move_number.abs.times { results << d.last }
  end
  results
end




puts directions
