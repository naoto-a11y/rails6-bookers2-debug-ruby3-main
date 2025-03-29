class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|

      t.timestamps
      t.integer :user_id
      t.integer :room_id
    end
  end
end
