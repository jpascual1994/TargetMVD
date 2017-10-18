class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :text
      t.references :chat
      t.timestamps
    end
    add_reference :messages, :from, index: true
    add_reference :messages, :to, index: true
  end
end
