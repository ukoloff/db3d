class Foto < ActiveRecord::Base
  validates :name, presence: {message: 'Не указано имя'}

  belongs_to :tool
end
