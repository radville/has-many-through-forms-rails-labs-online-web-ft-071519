class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments

  accepts_nested_attributes_for :comments
  accepts_nested_attributes_for :categories

  def categories_attributes=(categories_attributes)
    categories_attributes.values.each do |category_attributes|
      if category_attributes[:name].present?
        category = Category.find_or_create_by(category_attributes)
        if !self.categories.include?(category)
          self.categories << category
          self.save
        end
      end
    end
  end

end
