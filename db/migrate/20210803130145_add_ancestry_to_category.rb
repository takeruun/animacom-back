class AddAncestryToCategory < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :ancestry, :string, after: :name
    add_index :categories, :ancestry
  end
end
