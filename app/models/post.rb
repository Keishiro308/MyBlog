class Post < ApplicationRecord
  mount_uploader :image_name, PostImageUploader

  
end
