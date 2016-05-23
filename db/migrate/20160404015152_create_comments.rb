class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, index: true
      t.references :commenter, polymorphic: true, index: true
      t.text :comment
      t.string :url
      t.string :file_path
      t.string :file_name

      t.timestamps
    end
  end
end
