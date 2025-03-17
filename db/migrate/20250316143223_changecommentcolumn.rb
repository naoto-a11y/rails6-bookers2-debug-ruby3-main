class Changecommentcolumn < ActiveRecord::Migration[6.1]
  def change
    change_column :book_comments, :comment, :text
  end
end
