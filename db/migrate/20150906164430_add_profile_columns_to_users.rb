class AddProfileColumnsToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :name, null: false, default: ""
      t.string :location, null: false, default: ""
      t.string :photo_url, null: false, default: ""
      t.string :gender, null: false, default: ""
      t.text :bio, null: false, default: ""
      t.date :birthday
    end
  end
end
