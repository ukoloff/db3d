class User < ActiveRecord::Base
  acts_as_paranoid

  has_many :oauths, -> { order updated_at: :desc}

  def name
    oauths.first.info['info']['name'] rescue nil
  end
end
