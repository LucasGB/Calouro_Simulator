class AddHygieneToStudents < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :hygiene, :integer
  end
end
