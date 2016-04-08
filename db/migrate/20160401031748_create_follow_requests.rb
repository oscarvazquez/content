class CreateFollowRequests < ActiveRecord::Migration
  def change
    create_table :follow_requests do |t|
      t.references :follower, polymorphic: true, index: true
      t.references :followed, polymorphic: true, index: true
      t.string :message
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
