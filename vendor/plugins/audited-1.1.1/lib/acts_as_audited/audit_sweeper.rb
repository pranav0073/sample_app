
class AuditSweeper < ActionController::Caching::Sweeper #:nodoc:
  observe Audit
  def before_create(audit)

    audit.user ||= current_user if current_user
    audit.username ||= current_user[:name] if current_user[:name]
  end

  def current_user
    controller.send :current_user if controller.respond_to?(:current_user, true)
  end
end

ActionController::Base.class_eval do
  cache_sweeper :audit_sweeper
end
#Audit.add_observer(AuditSweeper.instance)


