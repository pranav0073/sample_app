require 'set'

class Tracker < ActiveRecord::Base
  belongs_to :auditable, :polymorphic => true
  #belongs_to :user, :polymorphic => true
  #before_create :set_version_number
  belongs_to :user, :polymorphic => true
  #serialize :changes
  before_create :return_false
  cattr_accessor :audited_class_names
  self.audited_class_names = Set.new
  def self.audited_classes
    self.audited_class_names.map(&:constantize)
  end
  def return_false
    return false
  end
end
