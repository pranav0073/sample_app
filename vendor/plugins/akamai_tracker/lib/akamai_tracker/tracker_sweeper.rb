

class TrackerSweeper < ActionController::Caching::Sweeper #:nodoc:
    observe Tracker
    def before_create(tracker)
        unless tracker.record_inserted
  	        tracker.user ||= Tracker.current
            unless tracker.user
                tracker.user = User.new 
                tracker.user.id = -1 
                tracker.user.name = "no value set"
            end
            ActiveRecord::Base.transaction do  
                sql ="insert into trackers (new_value,id,name,user_id,old_value,action,auditable_type,column_name,created_at,auditable_id)
                    values ('#{tracker.new_value}', trackers_seq.nextval, '#{tracker.user.name}',#{tracker.user.id},'#{tracker.old_value}', 
                    '#{tracker.action}','#{tracker.auditable_type}','#{tracker.column_name}',sysdate, '#{tracker.auditable_id}')"
                ActiveRecord::Base.connection.execute sql
                tracker.record_inserted = true
            end
        end
    end
end

ActionController::Base.class_eval do
    cache_sweeper :tracker_sweeper
end







