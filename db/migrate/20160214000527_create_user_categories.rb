class CreateUserCategories < ActiveRecord::Migration
  def change
    create_table :user_categories do |t|
      t.references :user, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
