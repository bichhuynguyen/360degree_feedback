class RenameCommentsToVersions < ActiveRecord::Migration
  def self.up
    rename_table :comments, :versions
  end

  def self.down
    rename_table :comments, :versions
  end
end
