class Tag < ActiveRecord::Base
  acts_as_paranoid

  has_many :t2ts
  has_many :tools, through: :t2ts
  belongs_to :creator, class_name: 'User'

  # Удалить теги, помеченные к удалению (давно не использующиеся)
  def self.expire
    where('expire_at < ?', Time.now).destroy_all rescue nil
  end

  def self.expire!
    Thread.new { expire }
  end

  # Хак для массового получения id-ов инструментов
  def tool_idz
    t2ts.map &:tool_id
  end
end
