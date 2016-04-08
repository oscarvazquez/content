class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :receiver, polymorphic: true, index: true
      t.text :message
      t.boolean :status, default: false
      t.references :sender, polymorphic: true, index: true
      t.timestamps
    end
  end
end