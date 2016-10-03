class Tool < ActiveRecord::Base
  acts_as_paranoid

  has_one :foto

  def date2str
    date.localtime.strftime '%d.%m.%Y' rescue '-'
  end
end
