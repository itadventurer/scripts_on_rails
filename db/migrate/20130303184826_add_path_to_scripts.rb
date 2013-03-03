class AddPathToScripts < ActiveRecord::Migration
  def change
    add_column :scripts, :path, :string
  end
end
