class AddAuthorityToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :authority, :string, default: "all", null: false
  end
end
