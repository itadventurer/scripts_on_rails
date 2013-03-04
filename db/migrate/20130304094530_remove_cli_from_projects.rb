class RemoveCliFromProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :cli
  end

  def down
  end
end
