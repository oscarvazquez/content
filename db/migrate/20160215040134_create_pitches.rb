class CreatePitches < ActiveRecord::Migration
  def change
    create_table :pitches do |t|
      t.text :pitch
      t.string :title
      t.references :user, index: true
      t.references :business, index: true
      t.integer :length
      t.float :price, default: 0
      t.string :timeline
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
