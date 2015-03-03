class <%= class_name %> < ActiveRecord::Migration
  def self.up
    create_table :trackers, :force => true do |t|
      t.column :auditable_id, :integer
      t.column :auditable_type, :string
      t.column :user_id, :integer
      t.column :user_type, :string
      t.column :username, :string
      t.column :action, :string
      t.column :version, :integer, :default => 0
      t.column :created_at, :datetime
      t.column :column_name, :string
      t.column :old_value, :string
      t.column :new_value, :string
    end
    
    add_index :trackers, [:auditable_id, :auditable_type], :name => 'auditable_index'
    add_index :trackers, [:user_id, :user_type], :name => 'user_index'
    add_index :trackers, :created_at  
  end

  def self.down
    drop_table :trackers
  end
end
