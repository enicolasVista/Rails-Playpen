class SplitNameToFirstAndLastNameParts < ActiveRecord::Migration
  def change
    rename_column :people, :name, :FirstName
    add_column :people, :LastName, :string
  end
end
