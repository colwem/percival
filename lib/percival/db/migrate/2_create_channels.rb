class CreateChannels < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :name
      t.integer :owner_id
      t.integer :user_count
      t.integer :user_max
      t.integer :total_lines
    end
  end
end
