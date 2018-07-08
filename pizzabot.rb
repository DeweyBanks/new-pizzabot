command = ARGV[0]
# grid_size_string = command[/\d[x]\d/]
coordinates_array = command.scan(/\(.*?\)/)
starting_location = { x_axis: 0, y_axix: 0 }
directions = []

def format_coordinates(coordinates)
  coordinates = coordinates
                .gsub(/[^\d,\.]/, '')
                .split(',')
                .map(&:to_i)

  {
    x_axis: coordinates.first,
    y_axis: coordinates.last
  }
end

def move(move_number, axes)
  results = []
  d = axes == 'y' ? %w[N S] : %w[E W]

  if move_number > 0
    move_number.times { results << d.first }
  else
    move_number.abs.times { results << d.last }
  end
  results
end

formatted_coordinates = coordinates_array.map do |coords|
  format_coordinates(coords)
end

formatted_coordinates.each do |coordinate|
  directions << move(coordinate[:x_axis] - starting_location[:x_axis], 'x')
  directions << move(coordinate[:y_axis] - starting_location[:y_axis], 'y')
  directions << 'D'
  starting_location = coordinate
end

puts directions.join
