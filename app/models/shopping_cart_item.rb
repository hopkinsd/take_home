class ShoppingCartItem < Sequel::Model
  many_to_one :shopping_cart
end
