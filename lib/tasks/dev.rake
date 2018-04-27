namespace :dev do
  task fake: [:fake_user, :fake_article, :fake_article_category, :fake_collect, :fake_comment, :fake_friend_requests2, :fake_friendship2 ]
  
  task fake_user: :environment do
    User.destroy_all

    30.times do |i|
      name = FFaker::Name::first_name
      user = User.new(
        name: name,
        email: "#{name}@example.com",
        password: "12345678",
        avatar: File.open(Rails.root.join("public/avatar/user#{rand(1..20)}.jpg")),
        intro: FFaker::Lorem::paragraphs,
      )
      user.save!
    end

    User.create(
      email: "admin@example.com",
      password: 12345678,
      name: "Admin",
      role: "admin",
      avatar: File.open(Rails.root.join("public/avatar/user20.jpg")),
      intro: FFaker::Lorem::paragraphs
      )
    
    puts "admin has been created"
    puts "now you have #{User.count} users data"
  end

  task fake_article: :environment do
    Article.destroy_all
    User.all.each do |user|
      rand(5).times do
        user.articles.create(
          title:FFaker::Book::title,
          content:FFaker::Lorem::sentence(30),
          authority:["myself", "friend", "all"].sample,
          image: File.open(Rails.root.join("public/image/#{rand(1..5)}.jpg")),
          published_at: Time.now
        )
      end
    end
    puts "have created fake articles by users"
    puts "now you have #{Article.count} article data"
  end

  task fake_draft: :environment do
    User.all.each do |user|
      rand(2).times do
        user.articles.create(
          title:FFaker::Book::title,
          content:FFaker::Lorem::sentence(30),
        )
      end
    end
    puts "have created fake drafts by users"
    puts "now you have #{Article.count} draft data"
  end


  task fake_article_category: :environment do
    ArticleCategory.destroy_all
    rand(70).times do |i|
      article_category = ArticleCategory.create(
        category_id: Category.all.sample.id,
        article_id: Article.all.sample.id
        )
    end
    puts "now you have #{ArticleCategory.count} article_category data"
  end

  task fake_collect: :environment do
    Collect.destroy_all

    50.times do |i|
      Collect.create!(
        user_id: User.all.sample.id,
        article_id: Article.all.sample.id
        )
      end
    puts "have created fake collect"
    puts "now you have #{Collect.count} collect data"
  end

  task fake_comment: :environment do
    Comment.destroy_all

    Article.all.each do |article|
      rand(2..10).times do |i|
        article.comments.create!(
          content:FFaker::Lorem.sentence,
          user:User.all.sample
          )
      end  
    end
    puts "have created fake comments"
    puts "now you have #{Comment.count} comment data"
  end

  task fake_friend_requests2: :environment do
    FriendRequests2.destroy_all
    200.times do |i|
      fake_friend_requests2 = FriendRequests2.create(
        user_id: User.all.sample.id,
        friend_id: User.all.sample.id
        )
    end
    puts "now you have #{FriendRequests2.count} friend_requests2 data"
  end

  task fake_friendship2: :environment do 
    Friendship2.destroy_all
    200.times do |i|
      friendship2 = Friendship2.create(
        user_id: User.all.sample.id,
        friend_id: User.all.sample.id
        )
    end
    puts "now you have #{Friendship2.count} friendship data"
  end

end








