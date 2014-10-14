class Topic < ActiveRecord::Base
  include Paginate
  has_many :posts
  default_scope { order('created_at DESC') }
end
