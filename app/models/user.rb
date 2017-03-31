class User
  attr_reader :id

  def initialize(id)
    @id = id
  end

  def add_item(product_id:, quantity:, **other)
    item = Product[product_id]
    current_shopping_cart.add_item item, quantity
  end

  def remove_item(product_id:, **other)
    item = Product[product_id]
    current_shopping_cart.remove_item item
  end

  def current_shopping_cart
    shopping_cart_dataset.where(purchase_date: nil).first ||
      ShoppingCart.create(user_id: id)
  end

  def purchase_hisotry
    shopping_cart_dataset.
      exclude(purchase_date: nil).
      order(Sequel.asc :purchase_date).
      all
  end

  def purchase_hisotry_hash
    carts_array = purchase_hisotry.map do |cart|
      [cart.purchase_date, cart.to_item_list]
    end

    Hash[carts_array]
  end

  private
  def shopping_cart_dataset
    ShoppingCart.where(user_id: id)
  end

end
