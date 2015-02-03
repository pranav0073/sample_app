class CreateOtherConnections < ActiveRecord::Migration
  def self.up
    create_table :other_connections do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :other_connections
  end
end
