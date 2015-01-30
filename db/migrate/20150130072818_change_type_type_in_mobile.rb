class ChangeTypeTypeInMobile < ActiveRecord::Migration
  def self.up
  	change_column :mobiles, :type, :string
  end

  def self.down
  	change_column :mobiles, :type, :integer
  end

end
