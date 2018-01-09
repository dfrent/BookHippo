class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


  def self.find_user(search)
    where(" username LIKE ? OR email LIKE ? " , "%#{search}%", "%#{search}%")
  end





end
