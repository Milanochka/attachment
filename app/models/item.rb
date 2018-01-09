class Item < ApplicationRecord
  has_many :basket_items

  before_destroy :there_is_a_item?

  validates :title, :description, :image_url, presence: true
  validates :price,numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\z}i,
    message: 'Не правильный формат изображения'
  }
  private

  def there_is_a_item?
    if basket_items.empty?
      return true
    else
      errors.add(:base, "товарные позиции есть")
      return false
    end
  end
end
