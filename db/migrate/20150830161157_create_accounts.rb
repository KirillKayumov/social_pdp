class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :provider, index: true
      t.string :uid, index: true
      t.references :user, index: true

      t.index [:provider, :uid], unique: true
    end
  end
end
