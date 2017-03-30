class ShoppingCart < Sequel::Model
  one_to_many :shopping_cart_items

  def add_item(item, quantity)
    return unless can_modify?
  end

  def purchase!
  end

  private
  def can_modify?
    !purchase_date
  end
end
