class CreateUserMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :user_matches do |t|
      t.references :user
      t.references :match
      t.timestamps
    end
  end
end
