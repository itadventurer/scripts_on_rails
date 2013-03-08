class AddVarsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :vars, :string
  end
end
