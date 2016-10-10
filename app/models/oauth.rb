class Oauth < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user

  serialize :info

  def name
    info['info']['name'] rescue nil
  end

  def info= data
    data.delete 'credentials'
    data['extra'].delete "access_token" rescue nil # Twitter
    super data
    info_will_change!
  end

  # Все авторизации, для которых пользователь не удалён
  scope :unorphaned, -> do
    # Приходится писать в условии users: вместо user: (???)
    joins(:user).where.not users: {id: nil}
  end
end
