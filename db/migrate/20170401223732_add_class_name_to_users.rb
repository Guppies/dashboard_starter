class AddClassNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :class_name, :string
  end
end
