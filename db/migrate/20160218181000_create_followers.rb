class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.references :follower, polymorphic: true, index: true
      t.references :followed, polymorphic: true, index: true
      t.boolean :status, default: true
      t.string :relationship

      t.timestamps
    end
  end
end
