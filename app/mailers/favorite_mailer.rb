class FavoriteMailer < ActionMailer::Base
  default from: "tacastly@gmail.com"

  def new_comment(user, post, comment)
    # New headers
    headers["Message-ID"] = "<comments/#{comment.id}@tiffit.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@tiffit.com>"
    headers["References"] = "<post/#{post.id}@tiffit.com>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
