class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.integer :status
      t.string :email
      t.string :phone
      t.text :auth_token
      t.text :password
      t.timestamps
    end
  end
end
