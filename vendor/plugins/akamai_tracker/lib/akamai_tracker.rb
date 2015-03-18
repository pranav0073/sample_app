
module Akamai #:nodoc:
  module Acts #:nodoc:
    module Track #:nodoc:
      CALLBACKS = [:track_create, :track_update, :track_destroy]
      def self.included(base) # :nodoc:
        base.extend ClassMethods
      end
      module ClassMethods
        def track_this_model(options = {})
          # don't allow multiple calls    
          return if self.included_modules.include?(Akamai::Acts::Track::InstanceMethods)
          options = {:protect => accessible_attributes.nil?}.merge(options)
          class_inheritable_reader :non_audited_columns
          
          
          if options[:only]
            except = self.column_names - options[:only].flatten.map(&:to_s)
          else
            except = [self.primary_key, inheritance_column, 'lock_version',
              'created_at', 'updated_at', 'created_on', 'updated_on']
            except |= Array(options[:except]).collect(&:to_s) if options[:except]
          end
          
          write_inheritable_attribute :non_audited_columns, except
          write_inheritable_attribute :auditing_enabled, true
          has_many :trackers, :as => :auditable
          attr_protected :audit_ids if options[:protect]
          Tracker.audited_class_names << self.to_s
          after_create  :track_create if !options[:on] || (options[:on] && options[:on].include?(:create))
          after_update  :track_update if !options[:on] || (options[:on] && options[:on].include?(:update))
          after_destroy :track_destroy if !options[:on] || (options[:on] && options[:on].include?(:destroy))
          attr_accessor :version
          include Akamai::Acts::Track::InstanceMethods
        end
      end
      module InstanceMethods
        def audited_attributes
          attributes.except(*non_audited_columns)
        end
      public
        def audited_changes
          changed_attributes.except(*non_audited_columns).inject({}) do |changes,(attr, old_value)|
            changes[attr] = [old_value, self[attr]]
            changes
          end
        end
        def track_create
          write_audit_for_create(:action => 'create', :changes => audited_attributes)
        end
        def track_update
          unless (changes = audited_changes).empty?
            #get updated_by
            #Tracker.current = details if details
            write_audit_for_update(:action => 'update', :changes => changes)
          end
        end
        def track_destroy
          write_audit_for_destroy(:action => 'destroy', :changes => audited_attributes)
        end
        def write_audit(attrs)
          self.trackers.create attrs if auditing_enabled
        end
        def write_audit_for_update(attrs)
          temp = attrs[:changes]
          attrs.except!(:changes)
          temp.each do |key, array|
            attrs[:column_name] = key
            attrs[:old_value] = array[0]
            attrs[:new_value] = array[1]
            ActiveRecord::Base.transaction do  
              self.trackers.create attrs 
            end
          end
        end
        def write_audit_for_create(attrs)
          temp = attrs[:changes]
          attrs.except!(:changes)
          temp.each do |key, val_f|
            attrs[:column_name] = key.to_s
            attrs[:old_value] = ""
            attrs[:new_value] = val_f
            ActiveRecord::Base.transaction do  
              self.trackers.create attrs 
            end 
          end
        end
        def write_audit_for_destroy(attrs)
          temp = attrs[:changes]
          attrs.except!(:changes)
          temp.each do |key, val_f|
            attrs[:column_name] = key.to_s
            attrs[:old_value] = val_f
            attrs[:new_value] = ""
            ActiveRecord::Base.transaction do  
              self.trackers.create attrs 
            end 
          end
        end
      end # InstanceMethods
    end
  end
end


module Akamai
  module Track
    module Setup 
      def self.included(base)
        base.before_filter :set_current_user
      end
      def set_current_user
        Tracker.current = current_user
      end
    end
  end
end

