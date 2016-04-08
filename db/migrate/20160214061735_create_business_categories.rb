class CreateBusinessCategories < ActiveRecord::Migration
  def change
    create_table :business_categories do |t|
      t.references :category, index: true
      t.references :business, index: true

      t.timestamps
    end
  end
end
