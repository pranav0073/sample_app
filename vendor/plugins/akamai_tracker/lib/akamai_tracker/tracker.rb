require 'set'

class Tracker < ActiveRecord::Base
  belongs_to :auditable, :polymorphic => true
  #belongs_to :user, :polymorphic => true
  #before_create :set_version_number
  belongs_to :user, :polymorphic => true
  #serialize :changes
  cattr_accessor :audited_class_names
  self.audited_class_names = Set.new
  def self.audited_classes
    self.audited_class_names.map(&:constantize)
  end
private
  def set_version_number
    max = self.class.maximum(:version,
      :conditions => {
        :auditable_id => auditable_id,
        :auditable_type => auditable_type,
        :column_name => column_name
      }) || 0
    self.version = max + 1
  end
end
