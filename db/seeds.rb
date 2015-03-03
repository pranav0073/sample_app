# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
require 'faker'
require 'populator'

User.delete_all
Phonebook.delete_all
Contact.delete_all
Email.delete_all
OtherConnection.delete_all
Mobile.delete_all

(1..2).each do |i|
	user = User.new
	user.name = Faker::Name.name
	user.email = "example#{i}@akamai.com"
	user.password = "testtest"
	user.password_confirmation = "testtest"
	if user.save!
		user = User.last
      	p = user.create_phonebook(:name => "#{user[:name]}'s Phonebook" )
	end
end

pb = Phonebook.all

pb.each do |x|
	if x.id > 0
		(1..20).each do 
			c = Contact.new
			c.name = Faker::Name.name
			c.phonebook_id = x.id.to_s
			c.twitter = ""
			c.fb =""
			c.github=""
			c.google_plus =""
			puts c.name
			c.save!
		end
	end
end


cont = Contact.all
cont.each do |x|
	if x.id > 0
		mtype = %w[HOME WORK OTHER]
		tagg = %w[stack chess zomato hackerEarth hacekerRank paypal]
		

		(1..50).each do
			e = Email.new
			e.address = Faker::Internet.email
			e.contact_id = x.id.to_s
			puts e.address
			puts "yes" if e.save!
		end



		(1..50).each do
			m = Mobile.new
			m.mtype = mtype[rand(mtype.length)]
			m.details = Faker::PhoneNumber.phone_number
			m.contact_id = x.id
			puts "yes" if m.save!
			puts m.details
		end

		(1..50).each do
			con = OtherConnection.new
			con.tag = tagg[rand(tagg.length)]
			con.details = Faker::Internet.user_name
			con.connection_type = con.tag
			con.contact_id = x.id
			#contact_id.to_s!
			#con.connection_type = tag[rand(tag.length)]
			con.connection_detail = Faker::Internet.user_name

			puts "yes" if con.save!
		end


	end
end


