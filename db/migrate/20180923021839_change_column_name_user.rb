class ChangeColumnNameUser < ActiveRecord::Migration
  def change
    rename_column :users, :remember_token, :digest_token
  end
end
