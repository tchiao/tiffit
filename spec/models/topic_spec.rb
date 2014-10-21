require 'rails_helper'

describe Topic do
  describe "scopes" do
    before do
      @public_topic = Topic.create # default is public_topic
      @private_topic = Topic.create(public: false)
    end

    describe "publicly_viewable" do
      it "returns a relation of all public topics" do
        expect(Topic.publicly_viewable).to eq([@public_topic])
      end
    end

    describe "privately_viewable" do
      it "returns a relation of all private topics" do
        expect(Topic.privately_viewable).to eq([@private_topic])
      end
    end

    describe "visible_to(user)" do
      it "returns all topics if user is present" do
        user = true
        expect(Topic.visible_to(user).count).to eq(2)
      end

      it "returns only public topics if user is nil" do
        user = nil
        expect(Topic.visible_to(user).count).to eq(1)
      end
    end
  end
end
