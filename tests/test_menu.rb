require './main'
require 'minitest/autorun'

class TestMenu < Minitest::Test
  def test_item_upload
    menu = Menu.new
    menu.add_item('Garlic Bread', 'Garlicy crunchy bread', 5.50, 'Dinner')
    assert_equal ({:item => 'Garlic Bread', :description => 'Garlicy crunchy bread', :price => 5.50}), menu.category['Dinner'][0], "Menu item not uploaded"
  end

  def test_item_remove
    menu = Menu.new
    menu.add_item('Garlic Bread', 'Garlicy crunchy bread', 5.50, 'Dinner')
    menu.remove_item('Dinner', 'Garlic Bread')
    assert_equal ({"Dinner"=>[]}), menu.category, "Menu item was not deleted"
  end

  def test_edit_item
    menu = Menu.new
    menu.add_item('Garlic Bread', 'Garlicy crunchy bread', 5.50, 'Dinner')
    edited_choices = ['Garlic Bread', :price, 6]
    menu.edit_item('Dinner', edited_choices)
    assert_equal ({:item => 'Garlic Bread', :description => 'Garlicy crunchy bread', :price => 6.00}), menu.category['Dinner'][0], "Garlic bread was not edited"
  end
end
