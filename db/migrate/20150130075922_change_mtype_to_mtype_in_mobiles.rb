class ChangeMtypeToMtypeInMobiles < ActiveRecord::Migration
  def self.up
  	rename_column :mobiles, :Mtype, :mtype
  end

  def self.down
  end
end

