class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :type
      t.string :link
      t.string :upload_link
      t.text :description
      t.references :user, index: true
      t.references :category, index: true
      t.string :excerpt

      t.timestamps
    end
  end
end
