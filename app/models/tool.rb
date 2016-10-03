class Tool < ActiveRecord::Base
  acts_as_paranoid
  
  has_one :foto
end
