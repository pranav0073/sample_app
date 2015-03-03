class ChangeColumnTypeInOthreConnection < ActiveRecord::Migration
  def self.up
  	change_column :other_connections, :contact_id, :string
  end

  def self.down
  end
end
