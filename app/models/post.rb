class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :post_tags
  has_many :tags, :through => :post_tags

  validates_presence_of :name, :content

  def tags_attributes=(tags_attributes)
    binding.pry
    tags_attributes.values.each do |tag_attributes|
      if tag_attributes[:name].present?
        self.tag = Tag.create(name: tag_attributes[:name], post_id: self)
      end
    end
  end

end
