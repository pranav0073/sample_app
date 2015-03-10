

class TrackerSweeper < ActionController::Caching::Sweeper #:nodoc:
  observe Tracker
  # @@count = 0
  # @@records =""
  # @@val = 0
    def before_create(tracker)
  	#if current_user
  		tracker.user ||= current_user
  		tracker.username ||= current_user[:name] if current_user[:name]
      tracker.user_id ||= current_user[:id] if current_user[:id]
  	#end
    # if @@count == 0
    #   @@val += 1
    #   @@records =  "insert into trackers (new_value,id,username,user_id,old_value,action,auditable_type,column_name,created_at) "
    #   @@records = "#{@@records} select '#{tracker.new_value}', #{@@val}, '#{tracker.username}',#{tracker.user_id},'#{tracker.old_value}','#{tracker.action}','#{tracker.auditable_type}','#{tracker.column_name}',sysdate from dual "
    #   @@count += 1
    # else
    #   @@val +=1
    #   @@records = "#{@@records} union all select '#{tracker.new_value}', #{@@val}, '#{tracker.username}',#{tracker.user_id},'#{tracker.old_value}','#{tracker.action}','#{tracker.auditable_type}','#{tracker.column_name}',sysdate from dual "
    #   @@count += 1
    # end
    #if @@count >=900

    ActiveRecord::Base.transaction do 
      #   #sql = @@records 
         sql ="insert into trackers (new_value,id,username,user_id,old_value,action,auditable_type,column_name,created_at,auditable_id)
          values ('#{tracker.new_value}', seq_tracker.nextval, '#{tracker.username}',#{tracker.user_id},'#{tracker.old_value}', 
           '#{tracker.action}','#{tracker.auditable_type}','#{tracker.column_name}',sysdate, '#{tracker.auditable_id}')"
         ActiveRecord::Base.connection.execute sql
      # end
    end
  end
  def current_user
    controller.send :current_user if controller.respond_to?(:current_user, true)
  end
end

ActionController::Base.class_eval do
  cache_sweeper :tracker_sweeper
end
#Audit.add_observer(AuditSweeper.instance)


