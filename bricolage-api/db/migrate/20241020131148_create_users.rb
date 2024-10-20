class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :role
      t.string :phone
      t.string :image_url
      t.string :username

      t.timestamps
    end
  end
end
