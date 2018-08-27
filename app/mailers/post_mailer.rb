class PostMailer < ApplicationMailer
  def post_mail(post)
    @post = post
    mail to: @post.user.email,subject:"投稿が完了しました"
  end
end
