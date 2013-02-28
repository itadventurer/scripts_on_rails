class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :language
      t.string :description
      t.string :cli

      t.timestamps
    end
  end
end
