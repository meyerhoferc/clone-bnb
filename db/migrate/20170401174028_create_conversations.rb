class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.integer :initiator_id
      t.integer :recipient_id
    end
  end
end
