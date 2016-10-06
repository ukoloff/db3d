class Oauth < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user

  serialize :info
end
