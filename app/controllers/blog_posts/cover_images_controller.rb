class BlogPosts::CoverImagesController  < ApplicationController
  include ActionView::RecordIdentifier # so we can use dom_id

  before_action :authenticate_user!
  before_action :set_blog_post

  def destroy
    @blog_post.cover_image.purge_later

    respond_to do |format|
      format.html { redirect_to edit_blog_post_path(@blog_post) }

      # this will remove the div from the page
      format.turbo_stream {
        render turbo_stream: turbo_stream.remove(
          dom_id(@blog_post, :cover_image)
        )
      }
    end
  end

  private

  #   rails routes -g cover_image
  #                 Prefix Verb   URI Pattern                                     Controller#Action
  # blog_post_cover_image DELETE /blog_posts/:blog_post_id/cover_image(.:format) blog_posts/cover_images#destroy
  def set_blog_post
    @blog_post = BlogPost.find(params[:blog_post_id])
  end
end
