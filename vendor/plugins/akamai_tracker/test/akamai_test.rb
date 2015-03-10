require File.dirname(__FILE__) + '/test_helper.rb'

	load_schema
  class Hickwall < ActiveRecord::Base
  	belongs_to :user
  	track_this_model :only => ["name"]
  end

  class Wickwall < ActiveRecord::Base
  	belongs_to :user
  	track_this_model :only => ["name"], :on => [:update]
  end

  class Tracker < ActiveRecord::Base
  end

  class Company < ActiveRecord::Base
  	belongs_to :user
  	track_this_model :except => ["revenue"], :on => [:update]
  end

  class User < ActiveRecord::Base
  	has_many :hickwalls
  	has_many :wickwalls
  	has_many :companies
  end


class AkamaiTest < Test::Unit::TestCase
 
  def test_schema_has_loaded_correctly
    #assert_equal [], Hickwall.all
    #assert_equal [], Wickwall.all
    #assert_equal [], User.all

  end
  def setup
  	User.delete_all
  	Tracker.delete_all
  	Wickwall.delete_all
  	@user = User.create!(:name =>"Pranav", :id => 1, :password => "testtest", :password_confirmation =>"testtest", :email => "pranav@akamai.com")
  	@wick = @user.wickwalls.create!(:name => "Arpit")
  	
  end

  def test_for_included_modules
  	assert_kind_of( Akamai::Acts::Track::InstanceMethods, Wickwall.new, ["msg"] )
  	assert_kind_of( Akamai::Acts::Track::InstanceMethods, Hickwall.new, ["msg"] )
  end

  def test_user_is_set
  	assert_equal User.count, 1
  end

  def test_auditing_only	
  	@user.hickwalls.create!(:name =>"Prashant" )
  	assert_equal Tracker.count, 1
  	assert_equal Tracker.last.new_value, "Prashant"
  end

  def test_auditing_on_update_only
  	assert_equal Tracker.count, 0
  	assert_equal Wickwall.count, 1
  	@wick.update_attribute(:name, "Gaurav")
  	assert_equal Tracker.count, 1
  end

  def test_prev_and_old_values
  	@wick.update_attribute(:name, "Gaurav")
  	@track = Tracker.last
  	assert_equal @track.new_value, "Gaurav"
  	assert_equal @track.old_value, "Arpit"
  end

  def test_for_except
  	@comp = @user.companies.create!(:name => "Inox", :revenue => "1M", :location => "U B City")
  	assert_equal Tracker.count, 0
  	@comp.update_attribute(:revenue, "1.5M")
  	assert_equal Tracker.count, 0
  	@comp.update_attribute(:name, "Ola Cabs")
  	assert_equal Tracker.count, 1
  end
end