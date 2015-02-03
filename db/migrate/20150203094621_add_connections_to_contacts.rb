class AddConnectionsToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :fb, :string
    add_column :contacts, :twitter, :string
    add_column :contacts, :github, :string
    add_column :contacts, :google_plus, :string
  end

  def self.down
    remove_column :contacts, :google_plus
    remove_column :contacts, :github
    remove_column :contacts, :twitter
    remove_column :contacts, :fb
  end
end
