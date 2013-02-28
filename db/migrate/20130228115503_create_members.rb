class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.int :project_id
      t.int :user_id
      t.boolean :is_admin
      t.boolean :can_create

      t.timestamps
    end
  end
end
