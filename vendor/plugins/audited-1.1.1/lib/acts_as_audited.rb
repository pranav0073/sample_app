

module CollectiveIdea #:nodoc:
  module Acts #:nodoc:
    # Specify this act if you want changes to your model to be saved in an
    # audit table.  This assumes there is an audits table ready.
    #
    #   class User < ActiveRecord::Base
    #     acts_as_audited
    #   end
    #
    # See <tt>CollectiveIdea::Acts::Audited::ClassMethods#acts_as_audited</tt>
    # for configuration options
    module Audited #:nodoc:
      CALLBACKS = [:audit_create, :audit_update, :audit_destroy]

      def self.included(base) # :nodoc:
        base.extend ClassMethods
      end

      module ClassMethods
        # == Configuration options
        #
        #
        # * +only+ - Only audit the given attributes
        # * +except+ - Excludes fields from being saved in the audit log.
        #   By default, acts_as_audited will audit all but these fields:
        #
        #     [self.primary_key, inheritance_column, 'lock_version', 'created_at', 'updated_at']
        #   You can add to those by passing one or an array of fields to skip.
        #
        #     class User < ActiveRecord::Base
        #       acts_as_audited :except => :password
        #     end
        # * +protect+ - If your model uses +attr_protected+, set this to false to prevent Rails from
        #   raising an error.  If you declare +attr_accessibe+ before calling +acts_as_audited+, it
        #   will automatically default to false.  You only need to explicitly set this if you are
        #   calling +attr_accessible+ after.
        #
        #     class User < ActiveRecord::Base
        #       acts_as_audited :protect => false
        #       attr_accessible :name
        #     end
        #
        def acts_as_audited(options = {})
          # don't allow multiple calls    
          return if self.included_modules.include?(CollectiveIdea::Acts::Audited::InstanceMethods)

          options = {:protect => accessible_attributes.nil?}.merge(options)

          class_inheritable_reader :non_audited_columns
          class_inheritable_reader :auditing_enabled
          
          if options[:only]
            except = self.column_names - options[:only].flatten.map(&:to_s)
          else
            except = [self.primary_key, inheritance_column, 'lock_version',
              'created_at', 'updated_at', 'created_on', 'updated_on']
            except |= Array(options[:except]).collect(&:to_s) if options[:except]
          end
          write_inheritable_attribute :non_audited_columns, except

          has_many :audits, :as => :auditable, :order => "#{Audit.quoted_table_name}.version"
          attr_protected :audit_ids if options[:protect]
          Audit.audited_class_names << self.to_s

          after_create  :audit_create if !options[:on] || (options[:on] && options[:on].include?(:create))
          before_update :audit_update if !options[:on] || (options[:on] && options[:on].include?(:update))
          after_destroy :audit_destroy if !options[:on] || (options[:on] && options[:on].include?(:destroy))

          attr_accessor :version

          extend CollectiveIdea::Acts::Audited::SingletonMethods
          include CollectiveIdea::Acts::Audited::InstanceMethods

          write_inheritable_attribute :auditing_enabled, true
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

        

        def audit_create
          write_audit_for_create(:action => 'create', :changes => audited_attributes)
        end

        def audit_update
          unless (changes = audited_changes).empty?
            write_audit_for_update_or_destroy(:action => 'update', :changes => changes)
          end
        end

        def audit_destroy
          write_audit_for_destroy(:action => 'destroy', :changes => audited_attributes)
        end

        def write_audit(attrs)
          self.audits.create attrs if auditing_enabled
        end

        def write_audit_for_update_or_destroy(attrs)
          temp = attrs[:changes]
          attrs.except!(:changes)
          temp.each do |key, array|
            attrs[:column_name] = key
            attrs[:old_value] = array[0]
            attrs[:new_value] = array[1]
            self.audits.create attrs if auditing_enabled
          end
        end

        def write_audit_for_create(attrs)
          temp = attrs[:changes]
          attrs.except!(:changes)
          temp.each do |key, val_f|
            attrs[:column_name] = key.to_s
            attrs[:old_value] = ""
            attrs[:new_value] = val_f
            self.audits.create attrs if auditing_enabled
          end
        end

        def write_audit_for_destroy(attrs)
          temp = attrs[:changes]
          attrs.except!(:changes)
          temp.each do |key, val_f|
            attrs[:column_name] = key.to_s
            attrs[:old_value] = val_f
            attrs[:new_value] = ""
            self.audits.create attrs if auditing_enabled
          end
        end


      end # InstanceMethods

      module SingletonMethods
        # Returns an array of columns that are audited.  See non_audited_columns
        def audited_columns
          self.columns.select { |c| !non_audited_columns.include?(c.name) }
        end

        # Executes the block with auditing disabled.
        #
        #   Foo.without_auditing do
        #     @foo.save
        #   end
        #
        def without_auditing(&block)
          auditing_was_enabled = auditing_enabled
          disable_auditing
          returning(block.call) { enable_auditing if auditing_was_enabled }
        end

        def disable_auditing
          write_inheritable_attribute :auditing_enabled, false
        end

        def enable_auditing
          write_inheritable_attribute :auditing_enabled, true
        end

        # All audit operations during the block are recorded as being
        # made by +user+. This is not model specific, the method is a
        # convenience wrapper around #Audit.as_user.

      end
    end
  end
end
