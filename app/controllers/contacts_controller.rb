class ContactsController < ApplicationController
  def new
  	@contact = Contact.new
  end

  def create
  	#params = params()
  	#user = current_user
  	#phonebook = current_user.phonebook
  	#contact = phonebook.contacts.create!(:name=>"#{params[:contact][:name]}")
  	#contact.mobiles.create!(:details => "#{params[:contact][:mobiles]}")
  	#contact.emails.create!(:address => "#{params[:contact][:emails]}")
  	#redirect_to phonebook_path
  	
  end

end
