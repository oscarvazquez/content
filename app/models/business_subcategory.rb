class BusinessSubcategory < ActiveRecord::Base
  belongs_to :subcategory
  belongs_to :business
end
