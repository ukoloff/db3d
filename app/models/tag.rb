class Tag < ActiveRecord::Base
  acts_as_paranoid

  has_many :t2t
  has_many :tools, through: :t2t
  belongs_to :creator, class_name: 'User'
end
