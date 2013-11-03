require 'support/factories'

[User, Tag, Article, Comment].map(&:delete_all)

5.times { FactoryGirl.create(:user) }

5.times { FactoryGirl.create(:tag) rescue next }

20.times do
  article = FactoryGirl.create(:article,
    user: User.where(role: %w[admin moderator]).sample,
    tag_list: Tag.all.sample(rand(3)).map(&:name).uniq.join(','),
    type: "Article"
  )

  (rand(2) > 0) ? article.publish! : nil

  if article.published?
    rand(5).times do
      FactoryGirl.create(:comment,
        article: article,
        user: User.all.sample
      )
    end
  end
end

10.times do
  article = FactoryGirl.create(:article,
    user: User.where(role: %w[admin moderator]).sample,
    tag_list: Tag.all.sample(rand(3)).map(&:name).uniq.join(','),
    type: %w[CV About].sample
  )

  (rand(2) > 0) ? article.publish! : nil

  if article.published?
    rand(5).times do
      FactoryGirl.create(:comment,
        article: article,
        user: User.all.sample
      )
    end
  end
end

FactoryGirl.create(:article,
  user: User.where(role: %w[admin moderator]).sample,
  type: "AboutSide"
).publish!
