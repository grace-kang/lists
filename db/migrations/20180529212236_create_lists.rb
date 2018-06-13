Hanami::Model.migration do
  change do
    create_table :lists do
      primary_key :id
      foreign_key :user_id, :users, on_delete: :cascade, null: false

      column :name, String, null: false
      column :done, 'bool', null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
