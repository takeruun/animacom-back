class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user
      t.references :category
      t.string :title
      t.string :sub_title
      t.string :body

      t.timestamps
    end
  end
end
