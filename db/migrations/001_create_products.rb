Sequel.migration do
  change do
    create_table(:products) do
      primary_key :id
      BigDecimal :price, :size=>[8, 2], null: false
      String :title, null: false
      Integer :available_inventory, null: false
    end
  end
end
