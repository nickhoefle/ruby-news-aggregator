class AddBlockedSourcesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :blocked_sources, :text, array: true, default: []
  end
end
