class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|

      t.timestamps
      t.integer :user_id
      t.integer :room_id
      t.text :message
    end
  end
end
