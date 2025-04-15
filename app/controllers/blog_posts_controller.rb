class BlogPostsController < ApplicationController
  # matchin view on /home/rprado_ubuntu/blog/app/views/blog_posts/index.html.erb
  def index
    # @ will share it with the view
    @blog_posts = BlogPost.all
  end

  def show
    @blog_post = BlogPost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def new
    # create a new in memory completely empty object, but not save it to db yet
    # so we can give to rails to generate a form
    # a match the form to the db columbs for us
    @blog_post = BlogPost.new
  end

  # params here is:
  # => #<ActionController::Parameters {"authenticity_token" => "REDACTED", "blog_post" => {"title" => "teste 12345", "body" => "78945611"}, "button" => "", "controller" => "blog_posts", "action" => "create"} permitted: false>
  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @blog_post = BlogPost.find(params[:id])
  end

  def update
    @blog_post = BlogPost.find(params[:id])
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def blog_post_params
    params.require(:blog_post).permit(:title, :body)
  end
end
