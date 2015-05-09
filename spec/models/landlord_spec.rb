require 'spec_helper'

describe Landlord do
  let(:landlord) { Landlord.create!(:name => "Landlord Name") }

  def make_rating(id, values)
    Rating.create!(:user_id => 0, :landlord_id => id,
      :general_1 => values[0], :general_1 => values[1],
      :helpfulness_1 => values[2], :helpfulness_2 => values[3],
      :professionalism_1 => values[4], :professionalism_2 => values[5], 
      :credibility_1 => values[6], :credibility_2 => values[7])
  end

  context "with no ratings" do
    it "has no ratings" do
      expect(landlord.ratings).to be_empty
    end
    it "has average ratings of 0" do
      expect(landlord.average_ratings).to eq([0,0,0,0])
    end
  end

  context "with ratings" do
    before(:each) do
      @ratings = [
        make_rating(landlord.id, [2,3,4,5,5,4,3,2]),
        make_rating(landlord.id, [3,5,2,5,3,5,2,5]),
        make_rating(landlord.id+1, [2,2,2,2,2,2,2,2])
      ]
    end
    it "has the right number of ratings" do
      expect(landlord.ratings.count).to eq(2)
    end
    it "averages the ratings correctly" do
      expect(landlord.average_ratings).to eq([2.5, 4, 3, 5])
    end
  end

  context "ratings pages" do
    before(:each) do
      @ratings = []
      13.times { @ratings << make_rating(landlord.id, [1,2,3,4]) }
    end
    it "can get all ratings at once" do
      expect(landlord.ratings).to eq(@ratings.reverse)
    end
    it "has 10 ratings on a full page" do
      expect(landlord.ratings(1)).to eq(@ratings[3..12].reverse)
    end
    it "has the correct # of ratings on a non-full page" do
      expect(landlord.ratings(2)).to eq(@ratings[0..2].reverse)
    end
    it "has no ratings on an empty page" do
      expect(landlord.ratings(3)).to eq([])
    end
  end

  context "searching" do
    before(:each) do
      names = ['Kevin Johnson', 'John Kevinson', 'Kevin Jones']
      @lls = names.map { |n| Landlord.create!(:name => n) }
    end
    it "sorts landlords by search position in last name" do
      expect(Landlord.search('John')).to eq([@lls[0], @lls[1]])
    end
    it "searches correctly when a space is used" do
      expect(Landlord.search("Kevin J")).to eq([@lls[0], @lls[2]])
    end
  end
end
