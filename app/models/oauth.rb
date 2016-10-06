class Oauth < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user

  serialize :info

  def name
    info['info']['name'] rescue nil
  end
end
