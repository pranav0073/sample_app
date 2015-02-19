# Include hook code herrequir

require 'yaffle'

Hash.class_eval do
  def is_a_special_hash?
    true
  end
end