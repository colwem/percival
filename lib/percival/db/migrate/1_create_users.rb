class CreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :name
      t.string :nick
      t.boolean   :registered 
      t.datetime :last_seen
      t.datetime  :first_seen
      t.integer   :last_seen_channel_id
      t.timestamps
    end

    add_index :users, :name,                :unique => true
    add_index :users, :reset_password_token, :unique => true
  end
end

# /msg NickServ info (nick)
