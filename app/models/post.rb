class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :post_tags
  has_many :tags, :through => :post_tags

  validates_presence_of :name, :content

  accepts_nested_attributes_for :tags, reject_if: proc { |attributes| attributes['name'].blank? }

  def tags_attributes=(tags_attributes)
    # binding.pry
    tags_attributes.values.each do |tag_attributes|
      binding.pry
      if tag_attributes[:name].present?
        self.tag = Tag.create(name: tag_attributes[:name], post_id: self)
      end
    end
  end

end
