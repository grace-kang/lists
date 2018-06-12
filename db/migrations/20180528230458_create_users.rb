Hanami::Model.migration do
  change do
    create_table :users do
      primary_key :id

      column :email, String, null: false, unique: true
      column :hashed_pass, String, null: false
      column :email_confirmed, 'bool', null: false
      column :token, String, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
