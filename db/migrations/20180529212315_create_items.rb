Hanami::Model.migration do
  change do
    create_table :items do
      primary_key :id
      foreign_key :list_id, :lists, on_delete: :cascade, null: false

      column :text, String, null: false
      column :done, 'bool', null: false
			column :position, Integer, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
