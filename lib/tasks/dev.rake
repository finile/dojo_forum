namespace :dev do
  task fake_user: :environment do
    User.destroy_all

    3.times do |i|
      name = FFaker::Name::first_name
      user = User.new(
        name: name,
        email: "#{name}@example.co",
        password: "12345678",
      )
      user.save!
      puts user.name
    end

    User.create(
      email: "root@example.com",
      password: 12345678,
      name: "Admin",
      role: "admin"
      )
    
    puts "admin has been created"
  end

  task fake_article: :environment do
    Article.destroy_all
    # file = File.open("#{Rails.root}/public/images/370x232.png")
    #from creating rand time of ticket
    #create 25 fack tickets information
    User.all.each do |user|
      rand(5).times do
        user.articles.create(
          title:FFaker::Book::title,
          content:FFaker::Lorem::sentence(30),
          published_at: Time.now
        )
      end
    end
    puts "have created fake articles by users"
    puts "now you have #{Article.count} article data"
  end

  task fake_article_category: :environment do
    rand(5).times do |i|
      article_category = ArticleCategory.create(
        category_id: Category.all.sample.id,
        article_id: Article.all.sample.id
        )
    end
    puts "now you have #{ArticleCategory.count} article_category data"
  end

end