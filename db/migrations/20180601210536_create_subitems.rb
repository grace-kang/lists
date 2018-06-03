Hanami::Model.migration do
  change do
    create_table :subitems do
      primary_key :id
      foreign_key :item_id, :items, on_delete: :cascade, null: false

      column :text, String, null: false
      column :done, 'bool', null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
