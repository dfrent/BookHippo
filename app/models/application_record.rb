class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


  def self.find_user(search)
    where(" username LIKE ? OR email LIKE ? " , "%#{search}%", "%#{search}%")
  end

  def self.look_for(search)
    where(" isbn LIKE ? OR username LIKE ? OR title LIKE ? OR author LIKE ? OR email LIKE ? ", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
  end

  def search_for
    
  end

end
