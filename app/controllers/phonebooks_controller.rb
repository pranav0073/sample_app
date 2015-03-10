class PhonebooksController < ApplicationController
  def index
  	@phonebook = current_user.phonebook
  	@contacts = @phonebook.contacts
  end

  def show
  	@phonebook = current_user.phonebook
  	@contact = @phonebook.contacts.find_by_id(params[:id])
  end

  def create
  end

  def new
  	redirect_to new_contact_path
  end

  def edit
    redirect_to edit_contact_path
  end

  def update
    @phonebook = current_user.phonebook
    @contact = @phonebook.contacts.find_by_id(params[:id])
  end

  def destroy
    redirect_to :url =>{:controller => 'contacts', :action => 'destroy'}
  end

  def prepend0
      #Tracker.delete_all
      redirect_to phonebook_path
      ActiveRecord::Base.transaction do
        @contacts = current_user.phonebook.contacts
        @contacts.each do |contact| 
          contact.mobiles.each do |mobile|
            mobile.details = "0#{mobile.details}"
            mobile.save
          end
        end
      end
      
    
  end
end
