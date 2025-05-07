require_relative "menu"
require 'titleize'

def prompt_add(menu)
  response = ''
  while response != 'y' && response != 'yes' do #Gets menu item information from user
    puts "\nPlease enter item name"
    name = gets.chomp.titleize
    return if name == 'Exit'
    puts "Please enter item description"
    description = gets.chomp.capitalize
    return if description == 'Exit'
    puts "Please enter price of item"
    price = gets.chomp
    return if price.downcase == 'exit'
    price = price.to_f.ceil(2)
    
    puts "\nIs this correct (Y)es or (N)o. Type 'exit' to return to main menu: \nName: #{name} \nDescription: #{description} \nPrice: #{price}"
    
    response = gets.chomp.downcase
    return if response == 'exit'
  end

  loop do #Prompts user to choose a category and stores the item into it
    puts "\nWould you like to: \n1. Enter the item into an existing category \n2. Add a new category"
    choice = gets.chomp
    return if choice.downcase == 'exit'

    case
    when choice == '1' && !menu.category.empty? #Prompts user to choose from exisiting categories and adds item into it
      puts "\nPlease choose from the following existing categories: #{menu.category.keys}"
      cat_name = gets.chomp.titleize
      return if cat_name == 'Exit'

      if menu.category.has_key?(cat_name)
        menu.add_item(name, description, price, cat_name)
        puts "Item added, returning to main menu..."
        return
      end

    when choice == '2' #Prompts user to start new category and initializes the item into it
      print "\nPlease enter the new category name: "
      cat_name = gets.chomp.titleize
      return if cat_name == 'Exit'

      if !menu.category.has_key?(cat_name)
        menu.add_item(name, description, price, cat_name)
        puts "Item added, returning to main menu..."
        return
      end
    end

    puts "Invalid Option, please try again."
  end
end

def prompt_remove(menu) #Display all existing items names and deletes the chosen item from menu
  if menu.category.empty?
    puts "\nThe menu is empty. Please add an item first..."
    return
  end

  items_list = [] #collect all the item names 
  menu.category.each do |cat_name, menu_items|
    menu_items.each do |item|
      items_list << item[:item]
    end
  end  

  loop do
    print "\nWhich item would you like to delete: "
    items_list.each {|item| print "|-#{item}-|"}
    puts "\n"

    choice = gets.chomp.titleize
    return if choice == 'Exit'

    if items_list.include?(choice)
      menu.remove_item(choice)
      puts "Removed item from menu. Returning to main menu..."
      return
    end

    puts "Invalid entry. Try again or exit"
  end
end

def start_menu(menu)
  loop do # Prints option menu and loops until user input is a valid input
    puts "\nPlease choose an option (#1-5). You may type 'exit' anytime to return to main menu:"
    puts "1. Print Menu"
    puts "2. Add an item"
    puts "3. Remove an item"
    puts "4. Edit an item"
    puts "5. Exit"
    input = gets.chomp.to_i

    case input
    when 1 #Prints current menu
      menu.print_menu()
    when 2 #Add item to menu
      prompt_add(menu)
    when 3
      prompt_remove(menu)
    when 4

    when 5
      return
    else
      puts "Not a valid option, please enter a value 1-5"
    end
  end
end

menu = Menu.new

start_menu(menu)
