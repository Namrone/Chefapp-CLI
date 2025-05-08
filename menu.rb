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

  def edit_item(cat_name, edited)
    if edited.class == String #Changes category name
      @category[edited] = @category.delete(cat_name)
    else
      @category[cat_name].each do |item| #Changes item information dependent on :item, :description, :price chosen by user
        if item[:item] == edited[0]
          edited[1] == :price ? item[edited[1]] = edited[2].to_f.ceil(2) : item[edited[1]] = edited[2]
          break
        end
      end
    end
  end

  def print_menu
    if @category.empty? || @category.values.flatten.empty? #Returns message if there's no existing items
      puts "\n~~~~The menu is empty. Please add an item first...~~~~"
      return
    end

    @category.each do |cat_name, menu_items|
      next if menu_items.empty?
      puts "\n=============================="
      puts cat_name
      puts "=============================="
      menu_items.each do |item|
        puts "#{item[:item]} ----- #{item[:description]} ------  $#{item[:price]}"
      end
    end
  end
end
