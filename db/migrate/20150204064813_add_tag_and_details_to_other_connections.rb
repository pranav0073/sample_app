class AddTagAndDetailsToOtherConnections < ActiveRecord::Migration
  def self.up
    add_column :other_connections, :tag, :string
    add_column :other_connections, :details, :string
  end

  def self.down
    remove_column :other_connections, :details
    remove_column :other_connections, :tag
  end
end
