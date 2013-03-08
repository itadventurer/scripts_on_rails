class AddParamsToScripts < ActiveRecord::Migration
  def change
    add_column :scripts, :params, :string
  end
end
