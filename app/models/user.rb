class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  def admin?
    role == 'admin'
  end

  def moderator?
    role == 'moderator'
  end

  def favorited(post)
    favorites.find_by_post_id(post.id)
  end

  def voted(post)
    votes.find_by_post_id(post.id)
  end

  def self.top_rated
    self.select('users.*')                                                        # select all attributes of user
      .select('COUNT(DISTINCT comments.id) AS comments_count')                    # count comments made by user
      .select('COUNT(DISTINCT posts.id) AS posts_count')                          # count posts made by users
      .select('COUNT(DISTINCT comments.id) + COUNT(DISTINCT posts.id) AS rank')   # add comment and post count with rank label
      .joins(:posts)                                                              # ties posts table to users table via user_id
      .joins(:comments)                                                           # ties comments table to users table via user_id
      .group('users.id')                                                          # instructs database to group results so users will be returned in distinct row
      .order('rank DESC')                                                         # instructs database to order results by rank, descending
  end

end
