class T2t < ActiveRecord::Base
  belongs_to :tag
  belongs_to :tool
  belongs_to :creator, class_name: 'User'
end
