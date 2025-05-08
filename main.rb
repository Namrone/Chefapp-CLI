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

      if menu.category.key?(cat_name)
        if menu.category[cat_name].any? {|item| item[:item] == name} #Prevents duplicate item in the same category
          puts "\n~~~~That item already exists in this category. Either 'exit' or add it into another category~~~~"
          next
        end
        menu.add_item(name, description, price, cat_name)
        puts "~~~~Item added, returning to main menu...~~~~"
        return
      end

    when choice == '2' #Prompts user to start new category and initializes the item into it
      print "\nPlease enter the new category name: "
      cat_name = gets.chomp.titleize
      return if cat_name == 'Exit'

      if !menu.category.has_key?(cat_name)
        menu.add_item(name, description, price, cat_name)
        puts "~~~~Item added, returning to main menu...~~~~"
        return
      end
    end

    puts "~~~~Invalid Option, please try again.~~~~"
  end
end

def prompt_remove(menu) #Display all existing items names and deletes the chosen item from menu
  if menu.category.empty? || menu.category.values.flatten.empty?
    puts "\n~~~~The menu is empty. Please add an item first...~~~~"
    return
  end

  items_list = [] #collect all the item names and category they're under
  menu.category.each do |cat_name, menu_items|
    menu_items.each do |item|
      items_list << {cat_name => item[:item]}
    end
  end  

  loop do
    print "\nWhich item would you like to delete: "
    items_list.each {|hash| print "|-#{hash}-|"}
    puts "\n"

    choice = gets.chomp.titleize
    return if choice == 'Exit'

    items_list.each do |hash|  #Locates the category which the item is under and removes item from that category
      if hash.has_value?(choice)
        print "Delete #{choice} from '#{hash.keys}' category? (Y)es or (N)o: "
        confirmed = gets.chomp.downcase
        return if confirmed == 'exit'
        cat_name = hash.key(choice)

        if confirmed == 'y' || confirmed == 'yes'
          menu.remove_item(cat_name, choice)
          puts "~~~~Removed item from menu. Returning to main menu...~~~~"
          return
        end
      end
    end

    puts "~~~~Invalid entry. Try again or exit~~~~"
  end
end

def prompt_edit(menu)
  if menu.category.empty? || menu.category.values.flatten.empty?
    puts "\n~~~~The menu is empty. Please add an item first...~~~~"
    return
  end

  menu.print_menu
  loop do
    puts "\nWhat would you like to edit (1-2):"
    puts "1. Category name"
    puts "2. Item Information"
    puts "3. Display menu again"
    choice = gets.chomp.downcase
    return if choice == 'exit'

    case choice
    when '1' #Displays all current categories and receives the change from user and applies change to menu
      loop do
        print "Which category would you like to change: "
        to_edit = gets.chomp.titleize
        return if to_edit == 'Exit'

        if menu.category.has_key?(to_edit)
          print "Type the new category name of '#{to_edit}': "
          edited = gets.chomp.titleize
          return if edited == 'Exit'

          puts "\nIs this correct (Y)es or (N)o -> #{edited}"
          confirm = gets.chomp.downcase
          return if confirm == 'exit'

          if confirm == 'y' || confirm == 'yes'
            menu.edit_item(to_edit, edited)
            puts "~~~~Category name edited. Returning to main menu...~~~~"
            return
          end
        end
        puts "~~~~Not a valid option please try again.~~~~"
      end

    when '2' #Displays all item information and receives the change from user and applies change to the targeted item
      loop do
        print "What category is the item you'd like to change under?: "
        cat_name = gets.chomp.titleize
        return if cat_name == 'Exit'

        while menu.category.has_key?(cat_name) do
          print "\nThese are the items in #{cat_name}: "
          menu.category[cat_name].each {|item| print "#{item} "}

          print "\nType the item name that you'd like to change: "
          item_request = gets.chomp.titleize
          return if item_request == 'Exit'

          
          if menu.category[cat_name].any? {|item| item[:item] == item_request} #Makes sure user entry is an actual item within menu
            puts "What would you like to change from #{item_request} (1-3)? \n1. The name \n2. The description \n3. The price"
            choice = gets.chomp.downcase
            return if choice == 'exit'

            case choice
            when '1'
              print "Enter the new name of the item: "
              choice = :item

            when '2'
              print "Enter the new description of the item: "
              choice = :description
            
            when '3'
              print "Enter the new price of the item: "
              choice = :price
            end
            edited = gets.chomp.titleize
            return if edited == 'Exit'

            if choice == :item && menu.category[cat_name].any? {|item| item[:item] == edited}#Makes sure no duplicate items in the same category
              puts "\n~~~~That item already exists in this category. Either 'exit' or pick a different name~~~~"
              next
            end

            edited = edited.to_f.ceil(2) if choice == :price
            print "Is this correct -> #{edited}. (Y)es or (N)o"
            confirmed = gets.chomp.downcase
            return if confirmed == 'exit'
            edited_choices = [item_request, choice, edited]

            if confirmed == 'y' || confirmed == 'yes' #Makes the change into menu
              menu.edit_item(cat_name, edited_choices)
              puts "~~~~Item has been edited. Returning to main menu...~~~~"
              return
            end
          end
          puts "~~~~Not a valid option please try again.~~~~"
        end
        puts "~~~~Not a valid option please try again.~~~~"
      end
      
    when '3'
      menu.print_menu
    else
      puts "~~~~Not a valid option please try again.~~~~"
    end
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
    input = gets.chomp

    case input
    when '1' #Prints current menu
      menu.print_menu()
    when '2' #Add item to menu
      prompt_add(menu)
    when '3' #Remove selected item from menu
      prompt_remove(menu)
    when '4' #Prompts user to choose which item to edit and what part to edit and asserts the changes
      prompt_edit(menu)
    when '5'
      return
    else
      puts "~~~~Not a valid option, please enter a value 1-5~~~~"
    end
  end
end

menu = Menu.new

start_menu(menu)
