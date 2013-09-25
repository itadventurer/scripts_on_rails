class AddFilenameToScripts < ActiveRecord::Migration
  def change
    add_column :scripts, :filename, :string
  end
end
