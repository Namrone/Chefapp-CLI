class Menu
  attr_accessor :item
  attr_accessor :description
  attr_accessor :price
  attr_accessor :section
  
  def main_menu
    input = ""
    while !(input >= 1 && input <=5) do
      puts "Please choose an option:"
      puts "1. Print Menu"
      puts "2. Add an item"
      puts "3. Remove an item"
      puts "4. Edit an item"
      puts "5. Exit"
      input = gets.chomp
    end
  end

  def add_item

  end

  def remove_item

  end

  def edit_item

  end

  def create_category

  end

  def print_menu

  end

  def print_edit_choice

  end
end
