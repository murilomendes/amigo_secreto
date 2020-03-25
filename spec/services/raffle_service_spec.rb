require 'rails_helper'

describe RaffleService do

  before :each do
    @campaign = create(:campaign, status: :pending)
  end

  describe "#call" do 
    context "when has more then two members" do
      before(:each) do
        create(:member, campaign: @campaign)
        create(:member, campaign: @campaign)
        create(:member, campaign: @campaign)

        @campaign.reload

        @results = RaffleService.new(@campaign).call
      end

      it "returns a hash" do 
        expect(@results.class).to eql(Hash)
      end

      it "all members are in results as member" do
        result_members = @results.map {|r| r.first}
        expect(result_members.sort).to eql(@campaign.members.sort)
      end

      it "all member are in results as a friend" do 
        result_friends = @result.map {|r| r.last}
        expect(result_friends.sort).to eql(@campaign.members.sort)
      end

      it "a member don`t get yourself" do 
        @result.each do |r| 
          expect(r.first).not_to eql(r.last)
        end
      end

      it "a member x don't get a member y that get the member x" do
        # Desafio
      end
    end

    context "when hasn`t more then two members" do 
      before(:each) do
        create(:member, campaing: @campaign)
        @campaign.reload

        @response = RaffleService.new(@campaign).call
      end

      it "raiser error" do
        expect(@response).to eql(false)
      end
    end
  end
end