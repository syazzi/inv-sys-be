class AddNotNullConstraintToDepartmentsName < ActiveRecord::Migration[7.1]
  def change
    change_column_null :vendors, :name, false
    change_column_null :items, :name, false
    change_column_null :items, :category, false
    change_column_null :departments, :name, false
  end
end
