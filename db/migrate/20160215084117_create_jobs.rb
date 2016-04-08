class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.references :user, index: true
      t.references :business, index: true
      t.references :category, index: true
      t.references :subcategory, index: true
      t.integer :timeline
      t.float :price
      t.string :title
      t.string :body
      t.string :meta_title
      t.string :meta_description
      t.string :length
      t.boolean :completed, default: false
      t.integer :status, default: 0
      t.integer :time_completed

      t.timestamps
    end
  end
end
