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

    while true do #Prompts user to choose a category and stores the item into it
      if !@category.empty?
        puts "Would you like to: \n1. Enter the item into an existing category \n2. Add a new category"
        choice = gets.chomp.to_i

        case choice
        when 1 #To enter item into an existing category
          puts "Please choose from the following existing categories: #{@category.keys}"
          cat_name = gets.chomp.titleize
          if @category.has_key?(cat_name) 
            @category[cat_name] << {:item => @item, :description => @description, :price => @price}
            break
          end
        end
        when 2 #To add a new category and add item into it
          print "Please enter the new category name: "
          cat_name = gets.chomp.titleize
          if !@category.has_key?(cat_name)
            @category[cat_name] = [{:item => @item, :description => @description, :price => @price}]
          end
          break
        end

        puts "Invalid Option. Please try again"
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
