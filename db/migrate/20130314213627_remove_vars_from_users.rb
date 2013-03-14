class RemoveVarsFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :vars
  end

  def down
  end
end
