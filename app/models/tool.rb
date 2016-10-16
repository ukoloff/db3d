class Tool < ActiveRecord::Base
  acts_as_paranoid

  validates :name, presence: {message: 'Не указано имя'}

  has_one :foto
  belongs_to :creator, class_name: 'User'
  has_many :t2ts
  has_many :tags, through: :t2ts

  def date2str
    date.localtime.strftime '%d.%m.%Y' rescue nil
  end

  def foto_name
    f = Foto.where(tool_id: id).select(:name).first
    f.name if f
  end

  def tagnames
    tags.order(1).pluck :name
  end

  def tagnames= names
    # TODO: Implement!
  end
end
