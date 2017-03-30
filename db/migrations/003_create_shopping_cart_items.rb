Sequel.migration do
  change do
    create_table(:shopping_cart_items) do
      foreign_key :shopping_cart_id, :shopping_carts, null: false
      foreign_key :product_id, :products, null: false
      Integer :quantity, null: false

      index [:shopping_cart_id, :product_id]
    end
  end
end
