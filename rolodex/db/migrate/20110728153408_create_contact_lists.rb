class CreateContactLists < ActiveRecord::Migration
  def self.up
    create_table :contact_lists, :id => false  do |t|
      t.integer :contact_id
      t.integer :list_id

      t.timestamps
    end
    add_index :contact_lists, [:contact_id, :list_id], :unique => true
  end

  def self.down
    remove_index :contact_lists, [:contact_id, :list_id]
    drop_table :contact_lists
  end
end
