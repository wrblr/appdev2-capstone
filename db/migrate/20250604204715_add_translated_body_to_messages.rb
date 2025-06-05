class AddTranslatedBodyToMessages < ActiveRecord::Migration[8.0]
  def change
    add_column :messages, :translated_body, :text
  end
end
