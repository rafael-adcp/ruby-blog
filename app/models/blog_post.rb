class BlogPost < ApplicationRecord
  has_rich_text :content
  has_one_attached :cover_image

  validates :title, presence: true
  validates :content, presence: true

  scope :sorted, -> { order(published_at: :desc) }
  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where("published_at <= ?", Time.current) }
  scope :scheduled, -> { where("published_at > ?", Time.current) }

  # so now we can do:
  # BlogPost.published
  # BlogPost.draft
  # BlogPost.scheduled
  # BlogPost.all (default provided by ActiveRecord)

  def draft?
    published_at.nil?
  end

  def published?
    published_at && published_at <= Time.current
  end

  def scheduled?
    published_at? && published_at > Time.current
  end
end
