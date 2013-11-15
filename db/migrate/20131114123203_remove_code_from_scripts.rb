class RemoveCodeFromScripts < ActiveRecord::Migration
  def up
  remove_column :scripts, :code
  end

  def down
  end
end
