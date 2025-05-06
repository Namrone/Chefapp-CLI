require_relative "menu"

menu = Menu.new
input = 0

while true do # Prints option menu and loops until user input is a valid input
  puts "Please choose an option (#1-5):"
  puts "1. Print Menu"
  puts "2. Add an item"
  puts "3. Remove an item"
  puts "4. Edit an item"
  puts "5. Exit"
  input = gets.chomp.to_i

  case input
  when 1
    
  when 2

  when 3

  when 4

  when 5
    break
  else
    puts "Not a vlaid option, please enter a value 1-5"
  end
end
