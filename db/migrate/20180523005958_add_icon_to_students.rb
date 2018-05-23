class AddIconToStudents < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :icon, :string
  end
end
