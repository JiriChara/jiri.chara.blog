require 'spec_helper'

describe User do
  context :ban do
    it "should have scope for banned users" do
      bad_boy  = FactoryGirl.create(:user, banned_at: Time.now)
      good_boy = FactoryGirl.create(:user)

      User.banned.should     include(bad_boy)
      User.banned.should_not include(good_boy)
    end

    it "should have scope for non-banned users" do
      bad_boy  = FactoryGirl.create(:user, banned_at: Time.now)
      good_boy = FactoryGirl.create(:user)

      User.not_banned.should     include(good_boy)
      User.not_banned.should_not include(bad_boy)
    end

    it "should ban user" do
      user = FactoryGirl.create(:user)
      user.ban!
      user.should be_banned
      user.banned_at.should be_present
    end

    it "should unban user" do
      user = FactoryGirl.create(:user)
      user.ban!
      user.unban!
      user.should_not be_banned
    end
  end
end
