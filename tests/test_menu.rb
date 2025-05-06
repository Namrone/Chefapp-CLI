require './main'
require 'minitest/autorun'

class TestMenu < Minitest::Test
  def test_item_upload
    menu = Menu.new
    menu.add_item('Garlic Bread', 'Garlicy crunchy bread', 5.50, 'Dinner')
    assert_equal ({:item => 'Garlic Bread', :description => 'Garlicy crunchy bread', :price => 5.50}), menu.category['Dinner'][0], "Menu item not uploaded properly"
  end
end
