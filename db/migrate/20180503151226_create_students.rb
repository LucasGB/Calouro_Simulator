class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.string :bachelor_degree
      t.float :coefficient
      t.float :cash
      t.integer :mood
      t.integer :hunger
      t.integer :health
      t.integer :energy
      t.datetime :last_active

      t.timestamps
    end
  end
end
