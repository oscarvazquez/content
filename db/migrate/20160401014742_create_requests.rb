class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.references :business, index: true
      t.references :category, index: true
      t.text :description
      t.integer :length
      t.string :title

      t.timestamps
    end
  end
end
