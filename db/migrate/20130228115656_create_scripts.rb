class CreateScripts < ActiveRecord::Migration
  def change
    create_table :scripts do |t|
      t.integer :project_id
      t.string :name

      t.timestamps
    end
  end
end
