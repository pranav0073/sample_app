

class TrackerSweeper < ActionController::Caching::Sweeper #:nodoc:
    observe Tracker
    def before_create(tracker)
        #100.times{puts User.current.id}
        unless tracker.record_inserted
  	        tracker.user ||= Tracker.current
            ActiveRecord::Base.transaction do  
                sql ="insert into trackers (new_value,id,name,user_id,old_value,action,auditable_type,column_name,created_at,auditable_id)
                    values ('#{tracker.new_value}', trackers_seq.nextval, '#{tracker.user.name}',#{tracker.user.id},'#{tracker.old_value}', 
                    '#{tracker.action}','#{tracker.auditable_type}','#{tracker.column_name}',sysdate, '#{tracker.auditable_id}')"
                ActiveRecord::Base.connection.execute sql
                tracker.record_inserted = true
            end
        end
    end
    # def current_user
    #     controller.send :current_user if controller.respond_to?(:current_user, true)
    # end
end
ActionController::Base.class_eval do
  cache_sweeper :tracker_sweeper
end







