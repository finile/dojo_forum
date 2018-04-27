json.data do
  json.array! @article do |article|
    json.partial! "article", article: article
  end
end