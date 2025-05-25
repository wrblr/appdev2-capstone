class CreateTranslations < ActiveRecord::Migration[8.0]
  def change
    create_table :translations do |t|
      t.text :body
      t.integer :message_id
      t.integer :language_id

      t.timestamps
    end
  end
end
