require 'set'

class Tracker < ActiveRecord::Base
  belongs_to :auditable, :polymorphic => true
  belongs_to :user, :polymorphic => true
  before_create :abort_internal_crate
  cattr_accessor :audited_class_names
  attr_accessor :record_inserted

  def self.current
    Thread.current[:user]
  end
    
  def self.current=(user)
    Thread.current[:user] = user
  end



  self.audited_class_names = Set.new
  def self.audited_classes
    self.audited_class_names.map(&:constantize)
  end
  def abort_internal_crate
    return false
  end
end
