class AddViewsCountToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :views_count, :integer, default: 0
  end
end
