class AddIndexToRecordsCreatedAt < ActiveRecord::Migration
  def change
    add_index :records, :created_at
  end
end
