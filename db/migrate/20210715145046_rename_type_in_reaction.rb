class RenameTypeInReaction < ActiveRecord::Migration[6.1]
  def change
    rename_column :reactions, :type, :kind
  end
end
