class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_code
      t.string :username
      t.string :address
      t.string :phone
      t.string :skype
      t.boolean :gender

      t.timestamps null: false
    end
  end
end
