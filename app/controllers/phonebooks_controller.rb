class PhonebooksController < ApplicationController
  def index
  	@phonebook = current_user.phonebook
  end

  def show
  	@phonebook = Phonebook.find_by_id(params[:id])
  end

end
