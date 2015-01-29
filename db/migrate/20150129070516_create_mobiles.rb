class CreateMobiles < ActiveRecord::Migration
  def self.up
    create_table :mobiles do |t|
      t.string :details
      t.integer :type
      t.string :contact_id

      t.timestamps
    end
  end

  def self.down
    drop_table :mobiles
  end
end
