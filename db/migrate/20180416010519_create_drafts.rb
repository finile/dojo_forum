class CreateDrafts < ActiveRecord::Migration[5.1]
  def change
    create_table :drafts do |t|
      t.string :title
      t.text :content
      t.string :image

      t.timestamps
    end
  end
end
