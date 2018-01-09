class Basket < ApplicationRecord
  has_many :basket_items, dependent: :destroy
end
