class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.integer :source_id
      t.string :url
      t.string :source

      t.timestamps
    end
  end
end
