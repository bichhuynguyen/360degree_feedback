class ChangeAttributesTableVersions < ActiveRecord::Migration
  def change
    remove_column :versions, :content, :text
    add_column :versions, :version, :string
    add_column :versions, :comment, :text
  end
end
