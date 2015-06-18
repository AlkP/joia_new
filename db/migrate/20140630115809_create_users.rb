class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name
      t.boolean :admin
      t.string  :email
      t.string  :password_digest

      t.references  :type, index: true

      t.timestamps
    end
  end
end
