class ShoppingCartItem < Sequel::Model
  many_to_one :shopping_cart
  many_to_one :product

  def can_purchase?
    product.available_inventory >= quantity
  end

  def purchase!
    product.available_inventory -= quantity
    product.save
  end
end
