coordinates = Array.new()
puts "Please enter a grid size.  example: 5x5"

grid_size = gets.chomp


puts "The grid is: #{grid_size}"
puts "\n"

puts "Please enter coordinates. example: 1,4"


location = gets.chomp
coordinates << location


puts "\n"
puts "Would you like to enter another coordinate?"

answer = gets.chomp[0].downcase

while answer == "y"
  puts "Please enter coordinates"
  location = gets.chomp
  coordinates << location
  puts "\n"
  puts "Would you like to enter another coordinate?"
  answer = gets.chomp[0].downcase
end

puts "Coordinates: \n"
puts coordinates
