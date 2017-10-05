class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.timestamps
    end
    add_reference :matches, :first_target, index: true
    add_reference :matches, :second_target, index: true
  end
end
