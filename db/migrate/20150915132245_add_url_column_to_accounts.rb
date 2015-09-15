class AddUrlColumnToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :url, :string, null: false, default: ""
  end
end
