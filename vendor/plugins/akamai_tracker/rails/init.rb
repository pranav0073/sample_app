#require File.join(File.dirname(__FILE__), 'rails', 'init')



require 'akamai_tracker/tracker'
require 'akamai_tracker'

ActiveRecord::Base.send :include, Akamai::Acts::Track

if defined?(ActionController) and defined?(ActionController::Base)
  require 'akamai_tracker/tracker_sweeper'
end
