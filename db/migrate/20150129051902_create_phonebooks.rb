class CreatePhonebooks < ActiveRecord::Migration
  def self.up
    create_table :phonebooks do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :phonebooks
  end
end
