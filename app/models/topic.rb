class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  default_scope { order('created_at DESC') }
  scope :visible_to, -> (user) { user ? all : publicly_viewable }
  scope :publicly_viewable, -> { where(public: true) }
  scope :privately_viewable, -> { where(public: false) }

end
