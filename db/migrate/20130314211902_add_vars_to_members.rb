class AddVarsToMembers < ActiveRecord::Migration
  def change
    add_column :members, :vars, :string
  end
end
