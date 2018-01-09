require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "attributes not be empty" do
    item = Item.new
    assert item.invalid?
    assert item.errors[:title].any?
    assert item.errors[:description].any?
    assert item.errors[:price].any?
    assert item.errors[:image_url].any?
  end

end
