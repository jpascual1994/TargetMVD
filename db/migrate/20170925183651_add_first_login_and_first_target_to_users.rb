class AddFirstLoginAndFirstTargetToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_login, :boolean, default: false
    add_column :users, :first_target, :boolean, default: false
  end
end
