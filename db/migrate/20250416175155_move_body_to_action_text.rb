class MoveBodyToActionText < ActiveRecord::Migration[8.0]
  def change
    # grabs batches ata time, so we don't run out of memory
    BlogPost.all.find_each do |post|
      post.update(content: post.body)
    end

    # droppign the column
    remove_column :blog_posts, :body
  end
end
