class AddMdmarkerToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :mdmarker, :boolean
  end
end
