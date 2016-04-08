class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, index: true
      t.references :commenter, polymorphic: true, index: true
      t.text :comment

      t.timestamps
    end
  end
end
