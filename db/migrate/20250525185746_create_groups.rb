class CreateGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :image
      t.integer :messages_count

      t.timestamps
    end
  end
end
