

class TrackerSweeper < ActionController::Caching::Sweeper #:nodoc:
  observe Tracker
  def before_create(tracker)
    tracker.user ||= current_user if current_user
    tracker.username ||= current_user[:name] if current_user[:name]
  end
  def current_user
    controller.send :current_user if controller.respond_to?(:current_user, true)
  end
end

ActionController::Base.class_eval do
  cache_sweeper :tracker_sweeper
end
#Audit.add_observer(AuditSweeper.instance)


