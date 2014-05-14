require 'spec_helper'

describe Landlord do
  #pending "add some examples to (or delete) #{__FILE__}"
  context "with no ratings" do
    it "has no ratings" do
      landlord = Landlord.create!(name: "Landlord Name")
      expect(landlord.ratings).to be_empty
    end
    it "has a rating count of 0" do
      landlord = Landlord.create!(name: "Landlord Name")
      expect(landlord.ratingstotal).to eq(0)
    end
    it "has average ratings of 0" do
      landlord = Landlord.create!(name: "Landlord Name")
      expect(landlord.average_ratings).to eq([0,0,0,0])
    end
  end

  it "sorts landlords by search position in last name" do
    ['Kevin Johnson',
     'John Kevinson',
     'Some other landlord'
    ].each do |name|
      Landlord.create!(name: name)
    end
    expect(Landlord.search('John')).to eq(['Kevin Johnson', 'John Kevinson'])
  end
end
