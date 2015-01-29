class AddUserIdToPhonebook < ActiveRecord::Migration
  def self.up
  	add_column :phonebooks, :user_id, :string
  	add_column :phonebooks, :name, :string
  end

  def self.down
  	remove_column :users, :remember_token
  end
end
