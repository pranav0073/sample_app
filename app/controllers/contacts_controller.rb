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

  def edit
    
    user = current_user
    phonebook = current_user.phonebook
    @contact = phonebook.contacts.find(params[:id])
  end


  def update
    #redirect_to  phonebook_path
    @contact = Contact.find(params[:id])
    if @contact.update_attributes(params[:contact])
      flash[:notice] = "Successfully updated contact."
      redirect_to "/phonebooks/#{params[:id]}"
    else
      render :action => 'edit'
    end
  end

  def destroy
   user = current_user
    phonebook = current_user.phonebook
    @contact = phonebook.contacts.find(params[:id])
    @contact.destroy
    flash[:notice] = "Successfully destroyed contact."
    redirect_to "/myphonebook"
  end

end
