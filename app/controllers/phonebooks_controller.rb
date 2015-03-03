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
    @contacts = current_user.phonebook.contacts
    size = @contacts.size
    (1..size).each do |i|
      contactId = @contacts[i-1].id
      #for each contactId extract the numbers associated
      @mobiles = Mobile.all(:select =>"details, id", :conditions => ["contact_id=?",[contactId]])
      msize = @mobiles.size
      (1..msize).each do |j|
        detailValue = @mobiles[j-1].details
        mobileId = @mobiles[j-1].id
        detailValue = "0#{detailValue}"
        Mobile.update(mobileId, :details => detailValue)
      end
     # Mobile.update_all({:details => "chanfew"}, {:contact_id => contactId})
    end
    redirect_to phonebook_path
  end
end
