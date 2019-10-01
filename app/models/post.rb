class Post < ApplicationRecord
  mount_uploader :image_name, PostImageUploader
  has_rich_text :content

  validates :user_id, presence: true
  validates :title, presence: true


end
