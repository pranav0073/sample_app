class AddFieldsToOtherConnections < ActiveRecord::Migration
  def self.up
    add_column :other_connections, :connection_type, :string
    add_column :other_connections, :connection_detail, :string
    add_column :other_connections, :contact_id, :integer
  end

  def self.down
    remove_column :other_connections, :contact_id
    remove_column :other_connections, :connection_detail
    remove_column :other_connections, :connection_type
  end
end
