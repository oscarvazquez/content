class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :likeable, polymorphic: true, index: true
      t.references :liker, polymorphic: true, index: true

      t.timestamps
    end
  end
end
