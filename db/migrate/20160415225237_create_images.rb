class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :url
      t.string :file_path
      t.string :file_type
      t.references :imageable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
