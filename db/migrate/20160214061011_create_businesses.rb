class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :login
      t.string :street_address
      t.string :zip_code
      t.string :city
      t.string :state
      t.string :country
      t.string :location
      t.string :facebook
      t.string :linked_in
      t.string :google
      t.string :twitter
      t.string :website
      t.string :profile_pic
      t.text :description
      t.boolean :pitch, default: true
      t.boolean :status, default: true
      t.boolean :confirmation_email, default: false
      t.string :email_token
      t.float :rating, default: 0
      t.integer :rating_count, default: 0
      t.float :lat, :decimal, {:precision=>10, :scale=>6}
      t.float :lng, :decimal, {:precision=>10, :scale=>6}
      t.integer :inquiries, default: 0
      t.integer :jobs_completed, default: 0
      t.string :excerpt

      t.timestamps
    end
  end
end
