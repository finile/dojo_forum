class ChangeArticleCategoriesToArticlesCategories < ActiveRecord::Migration[5.1]
  def change
    rename_table :article_categories, :articles_categories
  end
end
