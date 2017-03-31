class ShoppingCart < Sequel::Model
  one_to_many :shopping_cart_items

  def add_item(item, quantity)
    return 'cannot modify cart' unless can_modify?
    return 'invalid quantity' if item.available_inventory < quantity || quantity == 0

    existing = shopping_cart_items_dataset.where(product: item).first
    if existing
      existing.quantity = quantity
      existing.save
    else
      add_shopping_cart_item ShoppingCartItem.new(product: item, quantity: quantity)
    end
    nil
  end

  def remove_item(item)
    return 'cannot modify cart' unless can_modify?
    shopping_cart_items_dataset.where(product: item).delete
    nil
  end

  def purchase
    DB.transaction do
      return 'cannot purchase' unless can_purchase?
      purchase!
    end
  end

  def to_item_list
    shopping_cart_items_dataset.select(:product_id, :quantity).naked.all
  end

  private
  def can_modify?
    !purchase_date
  end

  def can_purchase?
    shopping_cart_items.all?(&:can_purchase?) && shopping_cart_items.size > 0
  end

  def purchase!
    shopping_cart_items.all?(&:purchase!)
    self.purchase_date = Time.now
    save
    nil
  end
end
