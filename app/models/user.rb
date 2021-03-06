class User < ActiveRecord::Base
  acts_as_paranoid

  has_many :oauths, -> { order updated_at: :desc}
  has_one :oauth, -> { order updated_at: :desc}

  def name
    oauth.name rescue nil
  end

  def authenticate?
    !disabled && oauths.any?
  end
end
