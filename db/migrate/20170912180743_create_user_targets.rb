class CreateUserTargets < ActiveRecord::Migration[5.1]
  def change
    create_table :user_targets do |t|
      t.string :title
      t.integer :area
      t.references :user
      t.references :topic
      t.timestamps
    end
  end
end
