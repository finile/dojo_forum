class AddCollectsCountToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :collects_count, :integer, default: 0
  end
end
