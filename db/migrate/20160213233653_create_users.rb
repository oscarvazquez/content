class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :login
      t.string :user_token
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.boolean :confirmation_email, default: false
      t.string :email_token
      t.boolean :set_current, default: false
      t.string :street_address
      t.string :city
      t.string :state
      t.string :country
      t.string :location
      t.string :zip_code
      t.float :lat, :decimal, {:precision=>10, :scale=>6}
      t.float :lng, :decimal, {:precision=>10, :scale=>6}
      t.text :summary
      t.text :excerpt
      t.boolean :has_resume, default: false
      t.string :resume
      t.string :profile_pic
      t.string :linked_in
      t.string :facebook
      t.string :google
      t.string :website
      t.string :twitter
      t.boolean :status, default: true
      t.float :rating, default: 0
      t.integer :rating_count, default: 0
      t.integer :response_time, default: 0
      t.integer :inquiries, default: 0
      t.integer :jobs_completed, default: 0

      t.timestamps
    end
  end
end
