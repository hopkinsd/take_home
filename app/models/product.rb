class Product < Sequel::Model
  one_to_many :shopping_cart_items
end
