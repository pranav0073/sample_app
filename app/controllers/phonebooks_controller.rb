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

end
