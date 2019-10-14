class Post < ApplicationRecord
  has_many :taggings, :dependent => :destroy
  has_many :tags, through: :taggings
  mount_uploader :image_name, PostImageUploader
  has_rich_text :content

  validates :title, presence: true
  NUMBER_POST=7

  def save_posts(savepost_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - savepost_tags
    new_tags = savepost_tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      new_tag =  Tag.find_or_create_by(name: new_name)
      self.tags << new_tag
    end
  end

  def related_posts(q = NUMBER_POST)
    Post.includes(:tags).where(tags: {name: tags.pluck(:name)}).where.not(id:id).distinct.sample(q)
  end


end
