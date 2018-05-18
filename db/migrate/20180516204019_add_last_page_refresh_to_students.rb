class AddLastPageRefreshToStudents < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :last_page_refresh, :datetime
  end
end
