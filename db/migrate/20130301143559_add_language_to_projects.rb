class AddLanguageToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :language_id, :int
    remove_column :projects, :language
  end
end
