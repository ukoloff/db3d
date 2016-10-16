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

  attr_accessor :current_user

  def tagnames=names
    # Список тегов
    ts = Array.wrap(names).map(&:strip).reject(&:blank?).map do |tag|
      Tag.where(name: tag).first_or_create creator: current_user
    end.uniq
    # Отключить отсутствующие
    t2ts.includes(:tag).where(tag: tags - ts).destroy_all
    # Подключить новые
    (ts - tags).each{|tag| t2ts.create tag: tag, creator: current_user}
  end
end
