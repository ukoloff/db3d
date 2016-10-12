class T2t < ActiveRecord::Base
  belongs_to :tag
  belongs_to :tool
  belongs_to :creator, class_name: 'User'

  after_create do |z|
    t=z.tag
    unless t.expire_at.nil?
      t.update_attributes expire_at: nil
    end
  end

  after_destroy do |z|
    t=z.tag
    if t.expire_at.nil? and t.t2ts.count==0
      t.update_attributes expire_at: 3.days.since
    end
  end
end
