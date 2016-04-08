class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :review
      t.integer :rating
      t.references :receiver, polymorphic: true, index: true
      t.references :writer, polymorphic: true, index: true
      t.references :job, index: true
      t.boolean :anonymous, default: false

      t.timestamps
    end
  end
end
