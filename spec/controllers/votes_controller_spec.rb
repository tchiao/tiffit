require 'rails_helper'

describe VotesController do
  include Devise::TestHelpers

  describe "vote methods" do
    before do
      @user = create(:user)
      sign_in @user
      @post = create(:post, user: @user)
      request.env["HTTP_REFERER"] = '/'
    end

    describe '#up_vote' do
      it "adds an upvote to the post" do
        expect {
          post(:up_vote, post_id: @post.id)
        }.to change {@post.up_votes}.by 1
      end
    end

    describe '#down_vote' do
      it "adds a downvote to the post" do
        expect {
          post(:down_vote, post_id: @post.id)
        }.to change {@post.down_votes}.by 1
      end
    end
  end
end