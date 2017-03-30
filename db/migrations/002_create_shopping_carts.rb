Sequel.migration do
  change do
    create_table(:shopping_carts) do
      primary_key :id
      Integer :user_id, null: false
      DateTime :purchase_date, default: nil

      index [:user_id, :purchase_date]
    end
  end
end
