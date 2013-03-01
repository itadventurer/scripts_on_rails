class AddFieldsToScripts < ActiveRecord::Migration
  def change
    add_column :scripts, :description, :text
    add_column :scripts, :code, :text
  end
end
