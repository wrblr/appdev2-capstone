class AddIsoCodeToLanguages < ActiveRecord::Migration[8.0]
  def change
    add_column :languages, :iso_code, :string
  end
end
