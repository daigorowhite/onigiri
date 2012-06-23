class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :comment_id
      t.integer :user_id
      t.string :contents
      t.date :commented

      t.timestamps
    end
  end
end
