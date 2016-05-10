class Product < ActiveRecord::Base
  belongs_to :brand
  belongs_to :category
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  has_attached_file :avatar, :styles => { :medium => "300x300#", :thumb => "100x100#" }, :default_url => "placeholder_:style.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates_presence_of :name, :price, :quantity, :description, :brand, :category
  validates_numericality_of :price, greater_than_or_equal_to: 0.01
  validates_numericality_of :quantity, greater_than_or_equal_to: 0

  def self.search_by_name_or_description(string)
  	where("name LIKE ? OR description LIKE ?", "%#{string}%", "%#{string}%")
  end

  private
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items Present')
        return false
      end
    end
  end

end
