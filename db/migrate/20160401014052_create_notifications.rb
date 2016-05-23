class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :receiver, polymorphic: true, index: true
      t.references :event, polymorphic: true, index: true
      t.references :initiator, polymorphic: true, index: true
      t.text :notification
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
