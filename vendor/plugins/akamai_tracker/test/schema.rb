ActiveRecord::Schema.define(:version => 0) do
  create_table :hickwalls, :force => true do |t|
    t.string :name
    t.string :user_id
    t.string :last_squawk
    t.datetime :last_squawked_at
  end

  create_table :wickwalls, :force => true do |t|
    t.string :name
    t.string :user_id
    t.string :last_tweet
    t.datetime :last_tweeted_at
  end

  create_table :woodpeckers, :force => true do |t|
    t.string :name
  end

  create_table :companies, :force => true do |t|
    t.string :name
    t.string :revenue
    t.string :location
    t.string :user_id
  end

  create_table :users, :force => true do |t|
    t.string :name 
    t.string :email
    t.string :encrypted_password
    t.string :salt

  end

  create_table :trackers, :force => true do |t|
    t.column :auditable_id, :integer
    t.column :auditable_type, :string
    t.column :user_id, :integer
    t.column :user_type, :string
    t.column :username, :string
    t.column :action, :string
    t.column :column_name, :text
    t.column :old_value, :string
    t.column :new_value, :string
    t.column :version, :integer, :default => 0
    t.column :created_at, :datetime
  end
end