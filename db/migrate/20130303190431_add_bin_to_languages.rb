class AddBinToLanguages < ActiveRecord::Migration
  def change
    add_column :languages, :bin, :string
  end
end
