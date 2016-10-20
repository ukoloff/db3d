class Foto < ActiveRecord::Base
  lazy_load :blob
  
  validates :name, presence: {message: 'Не указано имя'}

  belongs_to :tool
  belongs_to :creator, class_name: 'User'
end
