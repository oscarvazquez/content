class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.references :business, index: true
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.string :role, default: "member"

      t.timestamps
    end
  end
end
