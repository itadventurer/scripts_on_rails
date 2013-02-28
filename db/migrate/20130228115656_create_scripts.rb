class CreateScripts < ActiveRecord::Migration
  def change
    create_table :scripts do |t|
      t.int :project_id
      t.string :name

      t.timestamps
    end
  end
end
