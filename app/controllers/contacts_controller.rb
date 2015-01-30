class ContactsController < ApplicationController
  def new
  	@contact = Contact.new
  	1.times { @contact.mobiles.build}
    3.times { @contact.emails.build}
  	#COUNTY_OPTIONS = ["Avon", "Bedfordshire", "Berkshire"]
  end

  def create
  	params = params()
  	user = current_user
  	phonebook = current_user.phonebook
  	contact = phonebook.contacts.create!(params[:contact])
  	#contact.mobiles.create!(:details => "#{params[:contact][:mobile][:details]}",:Mtype =>"#{params[:contact][:mobile][:Mtype]}")
  	#contact.emails.create!(:address => "#{params[:contact][:emails]}")
  	redirect_to phonebook_path
  	
  end

end
