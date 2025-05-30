class AddCreatorToGroups < ActiveRecord::Migration[8.0]
  def change
    add_reference :groups, :creator, foreign_key: { to_table: :users }
  end
end
