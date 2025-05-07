class Menu
  attr_accessor :name, :description, :price, :category

  def initialize
    @category = Hash.new
  end

  def add_item (name, description, price, cat_name) #Adds the new menu item into corresponding category or forms new category
    if @category.has_key?(cat_name)
      @category[cat_name] << {:item => name, :description => description, :price => price}
    else
      @category[cat_name] = [{:item => name, :description => description, :price => price}]
    end
  end

  def remove_item(cat_name, item)
    @category[cat_name].delete_if {|hash| hash[:item] == item}
  end

  def edit_item

  end

  def print_menu
    @category.each do |cat_name, menu_items|
      puts "\n=============================="
      puts cat_name
      puts "=============================="
      menu_items.each do |item|
        puts "#{item[:item]} ----- #{item[:description]} ------  #{item[:price]}"
      end
    end
  end

  def print_edit_choice

  end
end
