class AddLatitudeAndLongitudeToUserTarget < ActiveRecord::Migration[5.1]
  def change
    add_column :user_targets, :latitude, :float
    add_column :user_targets, :longitude, :float
  end
end
