class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.integer :group_id
      t.integer :sender_id
      t.string :audio
      t.string :video
      t.text :body
      t.integer :original_language_id

      t.timestamps
    end
  end
end
