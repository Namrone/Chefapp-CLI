class Menu
  attr_accessor :menu_item
  attr_accessor :name
  attr_accessor :description
  attr_accessor :price
  attr_accessor :category

  def initializer
    @menu_item = Hash.new
    @category = Hash.new
    @price = 0
  end

  def print_category
    @category.map_with_index do |key, index|
      puts "#{index+1}. #{key}"
    end
  end

  def add_item 
    response = ''
    while response != 'y' || response != 'yes' do #Gets menu item information from user
      puts "Please enter item name"
      @name = gets.chomp
      puts "Please enter item description"
      @description = gets.chomp
      puts "Please enter price of item"
      @price = gets.chomp
      
      puts "Is this correct ((Y)es or (N)o)? \nName: #{@name} \nDescription: #{description} \nPrice: #{@price}"
      
      response = gets.chomp.downcase
    end

    while true do #Print category
      if !@category.empty?
        inputs = gets.chomp.capitalize
        if @category.has_key?(input) #Adds the item into the correct category

            break
          end
          puts "Please"
      end
      puts "What would you like to name your category?(ie. Appetizer, Dinner, Salads, Drinks)"
      
    end
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
