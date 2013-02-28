class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :project_id
      t.integer :user_id
      t.boolean :is_admin
      t.boolean :can_create

      t.timestamps
    end
  end
end
