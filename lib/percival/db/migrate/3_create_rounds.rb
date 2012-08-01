class CreateRounds < ActiveRecord::Migration
  def change
    create_table(:rounds) do |t|
      t.integer  :channel_id
      t.integer  :state
    end
  end
end
