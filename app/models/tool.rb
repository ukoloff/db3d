class Tool < ActiveRecord::Base
  acts_as_paranoid

  validates :name, presence: {message: 'Не указано имя'}

  has_one :foto

  def date2str
    date.localtime.strftime '%d.%m.%Y' rescue nil
  end
end
