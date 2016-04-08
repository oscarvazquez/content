class CreateUserSubcategories < ActiveRecord::Migration
  def change
    create_table :user_subcategories do |t|
      t.references :user, index: true
      t.references :subcategory, index: true

      t.timestamps
    end
  end
end
