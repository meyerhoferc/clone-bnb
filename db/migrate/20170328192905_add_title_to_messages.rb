class AddTitleToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :title, :string
    change_column :messages, :body, :text
  end
end
