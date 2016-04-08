class CreateBusinessSubcategories < ActiveRecord::Migration
  def change
    create_table :business_subcategories do |t|
      t.references :subcategory, index: true
      t.references :business, index: true

      t.timestamps
    end
  end
end
