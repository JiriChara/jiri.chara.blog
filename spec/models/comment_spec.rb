require 'spec_helper'

describe Comment do
  context :associations do
    it { should belong_to(:user) }
    it { should belong_to(:article) }
    it { should have_many(:karmas) }
  end

  context :validations do
    it { should validate_presence_of(:text) }
    it { should validate_presence_of(:article_id) }
    it { should validate_presence_of(:user_id) }
  end
end
