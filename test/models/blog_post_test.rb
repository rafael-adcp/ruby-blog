require "test_helper"

class BlogPostTest < ActiveSupport::TestCase
  test "draft? returns true for blog post" do
    # both do the same thing
    assert_equal BlogPost.new(published_at: nil).draft?, true
    assert BlogPost.new(published_at: nil).draft?
  end

  test "draft? returns false for a published blog post" do
    # both do the same thing
    assert_equal BlogPost.new(published_at: 1.year.ago).draft?, false
    refute BlogPost.new(published_at: 1.year.ago).draft?
  end


  test "draft? returns false for a scheduled blog post" do
    # both do the same thing
    assert_equal BlogPost.new(published_at: 1.year.from_now).draft?, false
    refute BlogPost.new(published_at: 1.year.from_now).draft?
  end
  # ...
  # ...
  # ...
  # ...
  # using fixtures
  test "[using fixture] draft? returns true for blog post" do
    # blog_posts is the name of the yaml file where the fixture is
    assert blog_posts(:draft).draft?
  end
end
