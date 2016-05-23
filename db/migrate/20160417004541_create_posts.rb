class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :post
      t.references :subcategory, index: true
      t.datetime :published
      t.references :writer, polymorphic: true, index: true

      t.timestamps
    end
  end
end
