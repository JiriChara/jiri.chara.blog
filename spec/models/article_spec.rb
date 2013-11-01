require 'spec_helper'

describe Article do
  context :associations do
    it { should belong_to(:user) }
    it { should have_many(:karmas) }
    it { should have_many(:comments) }
    it { should have_many(:images) }
    it { should have_and_belong_to_many(:tags) }
  end

  context :validations do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end

  context :tags do
    before(:each) { @article = FactoryGirl.create(:article) }

    it 'should create tags separated by comma' do
      @article.tag_list = 'foo,bar'
      @article.tags.collect(&:name).should include('foo', 'bar')
    end
  end

  context :publish do
    it 'should have scope for published articles' do
      published   = FactoryGirl.create(:article)
      unpublished = FactoryGirl.create(:article, published_at: nil)

      Article.published.should     include(published)
      Article.published.should_not include(unpublished)
    end

    it 'should have scope for unpublished articles' do
      published   = FactoryGirl.create(:article)
      unpublished = FactoryGirl.create(:article, published_at: nil)

      Article.unpublished.should_not include(published)
      Article.unpublished.should     include(unpublished)
    end

    it "should publish an article" do
      article = FactoryGirl.create(:article, published_at: nil)
      article.publish!

      article.should be_published
    end

    it "should unpublish an article" do
      article = FactoryGirl.create(:article)
      article.unpublish!

      article.should_not be_published
    end
  end
end
